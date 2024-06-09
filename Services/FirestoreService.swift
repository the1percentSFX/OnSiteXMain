//
//  FirestoreService.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 2/6/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


class OnSiteXDataService {
    let db = Firestore.firestore()
    
    func createNewDocument(dataPath :String, document :[String: Any] ) {
        db.document(dataPath).setData(document)
    }
    
    func updateDocument() {
    }
        
    func setDocument() {
    }
        
    
    func deleteDocument() {
    }
    
}


