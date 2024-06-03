//
//  Note.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 6/2/24.
//

import Foundation
import FirebaseFirestore

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
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "title": title,
            "detail": detail,
            "date": Timestamp(date: date),
            "type": type.rawValue,
            "sender": sender.rawValue
        ]
    }
    
    init(document: QueryDocumentSnapshot) {
        let data = document.data()
        self.id = document.documentID
        self.title = data["title"] as? String ?? ""
        self.detail = data["detail"] as? String ?? ""
        self.date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
        self.type = NoteType(rawValue: data["type"] as? String ?? "") ?? .regular
        self.sender = Sender(rawValue: data["sender"] as? String ?? "") ?? .user
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
