//
//  HomeView.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 6/2/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @Binding var notes: [Note]
    @State private var noteText: String = ""
    @State private var isChatPresented = false
    @State private var isSettingsPresented = false
    
    let userInitials = "VR"
    
    var addNoteClosure: (Note) -> Void
    
    var body: some View {
        VStack {
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
                Button(action: addNote) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                        .imageScale(.large)
                }
                .disabled(noteText.isEmpty)
                Button(action: startChat) {
                    Image(systemName: "message.fill")
                        .foregroundColor(.accentColor)
                        .imageScale(.large)
                }
            }
            .padding()
        }
        .navigationTitle("Home")
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
                    Spacer()
                    Text("OnSite")
                        .font(.largeTitle)
                        .bold()
                }
        )
    }
    
    private func delete(at offsets: IndexSet) {
        // Handle deletion of notes if needed
    }
    
    private func addNote() {
        let newNote = Note(id: UUID().uuidString, title: "Me", detail: noteText, date: Date(), type: .regular, sender: .user)
        self.addNoteClosure(newNote)
    }
    
    private func startChat() {
        guard !noteText.isEmpty else { return }
        let userNote = Note(id: UUID().uuidString, title: "Me", detail: noteText, date: Date(), type: .chat, sender: .user)
        self.notes.append(userNote)
        OpenAIService.shared.sendMessage(noteText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(notes: .constant([]), addNoteClosure: { _ in })
            .previewDevice("iPad (6th generation)")
    }
}
