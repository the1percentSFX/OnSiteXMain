//
//  ContentView.swift
//  OnSite
//
//  Created by Victor Ramirez on 1/17/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore  // Ensure Firestore and Timestamp are imported

enum NoteType: String, Codable {
    case regular = "regular"
    case chat = "chat"
}

enum Sender: String, Codable {
    case user = "user"
    case chat = "chat"
}

struct Note: Identifiable {
    let id: String
    var title: String
    var detail: String
    var date: Date
    var type: NoteType
    var sender: Sender
    
    // Dictionary representation for Firestore
    var dictionary: [String: Any] {
        return [
            "id": id,
            "title": title,
            "detail": detail,
            "date": Timestamp(date: date),  // Correct usage of Timestamp
            "type": type.rawValue,
            "sender": sender.rawValue
        ]
    }
    
    // Initialize a Note from Firestore Document
    init(document: QueryDocumentSnapshot) {
        let data = document.data()
        self.id = document.documentID
        self.title = data["title"] as? String ?? ""
        self.detail = data["detail"] as? String ?? ""  // Corrected type
        self.date = (data["date"] as? Timestamp)?.dateValue() ?? Date()  // Corrected fallback value
        self.type = NoteType(rawValue: data["type"] as? String ?? "") ?? .regular  // Corrected optional chaining
        self.sender = Sender(rawValue: data["sender"] as? String ?? "") ?? .user  // Corrected optional chaining
    }
}

extension Note {
    init(id: String = UUID().uuidString, title: String, detail: String, date: Date, type: NoteType, sender: Sender) {
        self.id = id
        self.title = title
        self.detail = detail
        self.date = date
        self.type = type
        self.sender = sender
    }
}

class FirestoreService {
    private let db = Firestore.firestore()
    
    func addNote(_ note: Note, completion: @escaping (Bool, Error?) -> Void) {
        db.collection("notes").document(note.id).setData(note.dictionary) { error in
            completion(error == nil, error)
        }
    }
    
    func deleteNote(_ noteId: String, completion: @escaping (Bool, Error?) -> Void) {
        self.db.collection("notes").document(noteId).delete { error in
            completion(error == nil, error)
        }
    }
    
    func fetchNotes(completion: @escaping ([Note]?, Error?) -> Void) {
        db.collection("notes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                completion([], nil)
                return
            }
            
            let notes = documents.compactMap { Note(document: $0) }
            completion(notes, nil)
        }
    }
}

struct HomeView: View {
    @Binding var notes: [Note]
    @State private var noteText: String = ""
    @State private var isChatPresented = false
    @State private var isSettingsPresented = false // For settings screen presentation
    var firestoreService = FirestoreService()
    
    // Dummy user initials - replace with actual user data
    let userInitials = "VR"
    func delete(at offsets: IndexSet) {
        
    }
    
    var addNoteClosure: (Note) -> Void
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                List {
                    ForEach(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.detail)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: delete)
                }
                HStack {
                    TextField("Type your note here...", text: $noteText)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        let newNote = Note(id: UUID().uuidString, title: "Me", detail: noteText, date: Date(), type: .regular, sender: .user)
                        self.addNoteClosure(newNote)
                    })  {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                    .disabled(noteText.isEmpty)
                    Button(action: startChat) {
                        Image(systemName: "message.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding()
            }
            .navigationTitle(" ")
            .navigationBarItems(
                leading:
                    Button(action: { isSettingsPresented = true }) {
                        ZStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                            Text(userInitials)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .sheet(isPresented: $isSettingsPresented) {
                        // SettingsView() // Your settings view here
                    },
                trailing:
                    HStack {
                        Spacer() // Pushes the text to the right
                        Text("OnSite")
                            .font(.largeTitle)
                            .bold()
                    }
            )
            .sheet(isPresented: $isChatPresented) {
                // Chat view or other content here
            }
        }
    }
    
    private func startChat() {
        guard !noteText.isEmpty else { return }
        // Use NoteType.chat and Sender.user explicitly if the compiler can't infer the enum type.
        let userNote = Note(id: UUID().uuidString, title: "Me", detail: noteText, date: Date(), type: .chat, sender: .user)
        self.notes.append(userNote)
        OpenAIService.shared.sendMessage(noteText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    // Use NoteType.chat and Sender.chat explicitly if the compiler can't infer the enum type.
                    let chatNote = Note(id: UUID().uuidString, title: "OnSite", detail: response, date: Date(), type: .chat, sender: .chat)
                    self.notes.append(chatNote)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                self.noteText = ""
            }
        }
    }
}
                

            struct ContentView: View {
                @State private var selectedTab: Tab = .home
                @State private var notes: [Note] = []
                
                var body: some View {
                    TabView(selection: $selectedTab) {
                        NavigationStack {
                            HomeView(notes: $notes, addNoteClosure: addNote)
                        }
                        .tabItem {
                            Image(systemName: "building.2")
                        }
                        .tag(Tab.home)
                        
                        NavigationStack {
                            CalendarView(notes: $notes)
                        }
                        .tabItem {
                            Image(systemName: Tab.calendar.iconName)
                        }
                        .tag(Tab.calendar)
                    }
                    .preferredColorScheme(.dark)
                    .onAppear {
                        fetchNotes()
                    }
                }
                
                func fetchNotes() {
                    FirestoreService().fetchNotes { result, _ in
                        if let result = result {
                            self.notes = result
                        }
                    }
                }
                
                func addNote(_ note: Note) {
                    FirestoreService().addNote(note) { success, _ in
                        if success {
                            fetchNotes()
                        }
                    }
                }
                
            }
            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }
            
            enum Tab {
                case home
                case calendar
                
                var iconName: String {
                    switch self {
                    case .home:
                        return "house"
                    case .calendar:
                        return "calendar"
                    }
                }
            }
            struct CalendarView: View {
                @Binding var notes: [Note]
                @State private var selectedDate = Date()
                @State private var showingDetail = false
                @State private var selectedNote: Note?
                
                var body: some View {
                    VStack {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                        
                        List(notes.filter { shouldDisplay(note: $0) }) { note in
                            Button(action: {
                                self.selectedNote = note
                                self.showingDetail.toggle()
                            }) {
                                VStack(alignment: .leading) {
                                    Text(note.title)
                                        .font(.headline)
                                    Text(note.detail)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .navigationTitle("Calendar")
                    .sheet(isPresented: $showingDetail) {
                        if let selectedNote = selectedNote {
                            NoteDetailView(note: selectedNote)
                        }
                    }
                }
                
                private func shouldDisplay(note: Note) -> Bool {
                    return Calendar.current.isDate(note.date, inSameDayAs: selectedDate) && (note.type == .regular || note.type == .chat)
                }
            }
            
            struct NoteDetailView: View {
                var note: Note
                
                var body: some View {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(note.title)
                            .font(.largeTitle)
                        Text(note.detail)
                            .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Note Details")
                }
            }
    
