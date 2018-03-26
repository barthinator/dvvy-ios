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

class FeedModel {
    var db: Firestore!
    
    //TODO: Add some error handling to ensure the data is valid. Eg the phone number
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func getPost() {
    }
    
    // Going to pull from the current user who is logged in
    //Should only pull the most recent 10 or something
    func getFeedUpdates() -> [Post] {
        //Suppose to grab the posts from the world document, then order them by
        //the date posted (only limit to 10 for now)
        var posts = [Post]()
        
        db.collection("feed").document("world").collection("posts").order(by: "datePosted").limit(to: 10).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    var dataDict = document.data()
                    
                    let documentPost = Post(
                        uid: dataDict["uid"] as! String,
                        description: dataDict["description"] as! String,
                        title: dataDict["title"] as! String,
                        datePosted: dataDict["datePosted"] as! Date
                    )
                    
                    posts.append(documentPost)
                }
            }
        }
        
        //For some reason this is always returning 0, maybe needs to complete first?
        return posts
    }
    
    
    
}

//protocol DocumentSerializable {
//    init?(dictionary:[String:Any])
//}
//
//struct FeedModel {
//    var user: String
//    var songLink: String
//    var description: String
//    var category: String
//    var timeStamp: Date
//
//    var dictionary:[String:Any] {
//        return [
//            "user":user,
//            "songLink": songLink,
//            "description": description,
//            "category": category,
//            "timeStamp": timeStamp
//        ]
//    }
//}

//extension Feed : DocumentSerializable {
//    init?(dictionary: [String:Any]) {
//        guard let user = dictionary["name"] as? String,
//        let songLink = dictionary["songLink"] as? String,
//        let description = dictionary["description"] as? String,
//        let category = dictionary["category"] as? String,
//        let timeStamp = dictionary["timeStamp"] as? Date
//    }
//}

