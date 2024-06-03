//
//  FeedView.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 5/28/24.
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
        // Simulate loading and fetching notes
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.notes = [
                Note(id: UUID().uuidString, title: "Project Update", detail: "New update on project X", date: Date(), type: .regular, sender: .user),
                Note(id: UUID().uuidString, title: "Reminder", detail: "Team meeting at 10 AM", date: Date(), type: .regular, sender: .user),
                // Add more sample notes as needed
            ]
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(notes: .constant([
            Note(id: UUID().uuidString, title: "Sample Note 1", detail: "Detail for sample note 1", date: Date(), type: .regular, sender: .user),
            Note(id: UUID().uuidString, title: "Sample Note 2", detail: "Detail for sample note 2", date: Date(), type: .regular, sender: .user)
        ]))
    }
}






//import Foundation
//import SwiftUI
//
//struct FeedView: View {
//    @Binding var notes: [Note]
//    @State private var isLoading = false
//    @State private var errorMessage: String?
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if isLoading {
//                    ProgressView()
//                } else if let errorMessage = errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                } else {
//                    List {
//                        ForEach(notes) { note in
//                            VStack(alignment: .leading) {
//                                Text(note.title)
//                                    .font(.headline)
//                                Text(note.detail)
//                                    .font(.subheadline)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Feed")
//            .onAppear {
//                fetchFeedNotes()
//            }
//        }
//    }
//    
//    private func fetchFeedNotes() {
//        // Simulate loading and fetching notes
//        isLoading = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.isLoading = false
//            self.notes = [
//                Note(id: UUID().uuidString, title: "Project Update", detail: "New update on project X", date: Date(), type: .regular, sender: .user),
//                Note(id: UUID().uuidString, title: "Reminder", detail: "Team meeting at 10 AM", date: Date(), type: .regular, sender: .user),
//                // Add more sample notes as needed
//            ]
//        }
//    }
//}
//
//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView(notes: .constant([]))
//    }
//}
