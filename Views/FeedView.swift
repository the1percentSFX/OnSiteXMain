//
//  FeedView.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 6/2/24.
//

import Foundation
import SwiftUI

struct FeedView: View {
    @Binding var notes: [Note]
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.detail)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Feed")
            .onAppear {
                fetchFeedNotes()
            }
        }
    }
    
    private func fetchFeedNotes() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.notes = [
                Note(id: UUID().uuidString, title: "Project Update", detail: "New update on project X", date: Date(), type: .regular, sender: .user),
                Note(id: UUID().uuidString, title: "Reminder", detail: "Team meeting at 10 AM", date: Date(), type: .regular, sender: .user)
            ]
        }
    }
}
