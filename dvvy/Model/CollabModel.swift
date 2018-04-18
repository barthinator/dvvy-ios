//
//  Collab
//  dvvy
//
//  Created by Nathan Frasier on 3/15/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase

struct CollabPost {
    var uid: String
    var description: String
    var title: String
    //var profImage: UIImage
    var datePosted: Date
    var category: String
    var name: String
}

protocol CollabModelDelegate: class {
    func finishedLoading(_ posts: [CollabPost]?)
}

class CollabModel {
    var db: Firestore!
    weak var delegate: CollabModelDelegate?
    var posts = [CollabPost]()
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    // Going to pull from the current user who is logged in
    //Should only pull the most recent 10 or something
    func getCollabUpdates() {
        //Suppose to grab the posts from the world document, then order them by
        //the date posted (only limit to 10 for now)
        
        db.collection("collab").document("global").collection("collabpost").order(by: "datePosted", descending: true).limit(to: 10).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                //Clears it out. Maybe its more efficient to check if there is anything new? need to research more
                self.posts = [CollabPost]()
                
                for document in querySnapshot!.documents {
                    
                    var dataDict = document.data()
                    
                    let documentPost = CollabPost(
                        uid: dataDict["uid"] as! String,
                        description: dataDict["description"] as! String,
                        title: dataDict["title"] as! String,
                        datePosted: dataDict["datePosted"] as! Date,
                        category: dataDict["category"] as! String,
                        name: dataDict["name"] as! String
                    )
                    
                    self.posts.append(documentPost)
                }
                self.delegate?.finishedLoading(self.posts)
            }
        }
    }
    
    func makePost(post: CollabPost){
        
        //Sets the data of the global collab collection
        let ref = db.collection("collab").document("global").collection("collabpost").document()
        ref.setData([
            "uid": post.uid,
            "description": post.description,
            "title": post.title,
            "datePosted": post.datePosted,
            "category": post.category,
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


