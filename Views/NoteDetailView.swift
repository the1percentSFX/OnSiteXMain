//
//  NoteDetailView.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 6/2/24.
//

import Foundation
import SwiftUI

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

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(note: Note(
            id: UUID().uuidString,
            title: "Sample Note",
            detail: "This is a sample note detail.",
            date: Date(),
            type: .regular,
            sender: .user
        ))
    }
}
