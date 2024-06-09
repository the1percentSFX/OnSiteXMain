//
//  HomeTabView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/27/24.
//

import SwiftUI

struct HomeTabView: View {
    var notes: [Note] =  [Note(id: UUID().uuidString, title: "Me", detail: "", date: Date(), type: .regular, sender: .user)]
    @State private var noteText: String = ""
    @State private var isChatPresented = false
    @State private var isSettingsPresented = false // For settings screen presentation
    var firestoreService = FirestoreService()
    
    // Dummy user initials - replace with actual user data
    let userInitials = "VR"
    func delete(at offsets: IndexSet) {
        
    }
    
//    var addNoteClosure: (Note) -> Void
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
//                        self.addNoteClosure(newNote)
                    })  {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                    .disabled(noteText.isEmpty)
//                    Button(action: startChat) {
//                        Image(systemName: "message.fill")
//                            .foregroundColor(.accentColor)
//                    }
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
//    private func startChat() {
//        guard !noteText.isEmpty else { return }
//        // Use NoteType.chat and Sender.user explicitly if the compiler can't infer the enum type.
//        let userNote = Note(id: UUID().uuidString, title: "Me", detail: noteText, date: Date(), type: .chat, sender: .user)
//        self.notes.append(userNote)
//        OpenAIService.shared.sendMessage(noteText) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    // Use NoteType.chat and Sender.chat explicitly if the compiler can't infer the enum type.
//                    let chatNote = Note(id: UUID().uuidString, title: "OnSite", detail: response, date: Date(), type: .chat, sender: .chat)
//                    self.notes.append(chatNote)
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//                self.noteText = ""
//            }
//        }
//    }
}

#Preview {
    HomeTabView()
}
