//
//  FeedModelController.swift
//  dvvy
//
//  Created by Nathan Frasier on 3/15/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase

struct Post {
    var uid: String
    var description: String
    var title: String
    //var profImage: UIImage
    var datePosted: Date
}

protocol FeedModelDelegate: class {
    func finishedLoading(_ posts: [Post]?)
}

class FeedModel {
    var db: Firestore!
    weak var delegate: FeedModelDelegate?
    var posts = [Post]()
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    // Going to pull from the current user who is logged in
    //Should only pull the most recent 10 or something
    func getFeedUpdates() {
        //Suppose to grab the posts from the world document, then order them by
        //the date posted (only limit to 10 for now)
        
        db.collection("feed").document("world").collection("posts").order(by: "datePosted", descending: true).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                //Clears it out. Maybe its more efficient to check if there is anything new? need to research more
                self.posts = [Post]()
                
                for document in querySnapshot!.documents {
                    
                    var dataDict = document.data()
                    
                    let documentPost = Post(
                        uid: dataDict["uid"] as! String,
                        description: dataDict["description"] as! String,
                        title: dataDict["title"] as! String,
                        datePosted: dataDict["datePosted"] as! Date
                    )
                    
                    self.posts.append(documentPost)
                }
                self.delegate?.finishedLoading(self.posts)
            }
        }
    }
    
    
    //Get user created posts
    func getUserCreatedPosts(uid: String){
        
        db.collection("feed").document("world").collection("posts").whereField("uid", isEqualTo: uid)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    //Clears it out. Maybe its more efficient to check if there is anything new? need to research more
                    
                    self.posts = [Post]()
                    
                    for document in querySnapshot!.documents {
                        var dataDict = document.data()
                        
                        let documentPost = Post(
                            uid: dataDict["uid"] as! String,
                            description: dataDict["description"] as! String,
                            title: dataDict["title"] as! String,
                            datePosted: dataDict["datePosted"] as! Date
                        )
                        
                        self.posts.append(documentPost)
                    }
                    self.delegate?.finishedLoading(self.posts)
                }
        }
    }
    
    func makePost(post: Post){
        
        //Sets the data of the global collab collection
        let ref = db.collection("feed").document("world").collection("posts").document()
        ref.setData([
            "uid": post.uid,
            "description": post.description,
            "title": post.title,
            "datePosted": post.datePosted
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    
    
}

