//
//  PortfolioModel.swift
//  dvvy
//
//  Created by Jason Kirschenmann on 4/30/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//
import Firebase
struct Portfolio {
    var uid: String
    var url: String
    var name: String
}
protocol PortfolioModelDelegate: class {
    func finishedLoading(_ posts: [Portfolio]?)
}
class PortfolioModel {
    var db: Firestore!
    weak var delegate: PortfolioModelDelegate?
    var posts = [Portfolio]()
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func makePost(post: Portfolio){
        
        //Sets the data of the global collab collection
        let ref = db.collection("portfolio").document("Portfolio").collection("portfolio").document()
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
