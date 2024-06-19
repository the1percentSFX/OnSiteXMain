//
//  ContentView.swift
//  OnSite
//
//  Created by Victor Ramirez on 1/17/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @State private var notes: [Note] = []
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                FeedView(notes: $notes)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: Tab.feed.iconName)
                Text("Feed")
            }
            .tag(Tab.feed)
            
            NavigationView {
                HomeView(notes: $notes, addNoteClosure: addNote)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: Tab.home.iconName)
                Text("Home")
            }
            .tag(Tab.home)
            
            NavigationView {
                CalendarView(notes: $notes)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: Tab.calendar.iconName)
                Text("Calendar")
            }
            .tag(Tab.calendar)
        }
        .preferredColorScheme(.dark)
        .onAppear {
            fetchNotes()
        }
    }
    
    func fetchNotes() {
        // Simulate fetching notes if needed
    }
    
    func addNote(_ note: Note) {
        // Simulate adding a note if needed
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad (6th generation)")
    }
}

enum Tab {
    case feed
    case home
    case calendar
    
    var iconName: String {
        switch self {
        case .feed:
            return "square.and.pencil"
        case .home:
            return "house"
        case .calendar:
            return "calendar"
        }
    }
}
