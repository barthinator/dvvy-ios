//
//  UserModel.swift
//  dvvy
//
//  Created by David Bartholomew on 3/2/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase

class UserModel {
    
    var db: Firestore!
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func addDavid() {
        // [START add_ada_lovelace]
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": "david",
            "lastname": "bartholomew"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
}
