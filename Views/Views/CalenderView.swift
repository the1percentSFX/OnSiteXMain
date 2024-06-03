//
//  CalenderView.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 5/29/24.
//

import Foundation
import SwiftUI

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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(notes: .constant([]))
            .previewDevice("iPad (6th generation)")
    }
}
