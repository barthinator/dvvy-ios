//
//  SubmitModel.swift
//  dvvy
//
//  Created by Zack Goldstein on 4/25/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase

struct Submit {
    var uid: String
    var url: String
    var name: String
}

class SubmitModel {
    var db: Firestore!
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    
    func makePost(post: Submit){
        //Sets the data of the global collab collection
        let ref = db.collection("submission").document("submit").collection("submission").document()
        ref.setData([
            "uid": post.uid,
            "url": post.url,
            "name": post.name
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    
}
