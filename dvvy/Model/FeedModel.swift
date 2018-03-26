//
//  FeedModelController.swift
//  dvvy
//
//  Created by Nathan Frasier on 3/15/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase

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
    
    // Going to pull from the current user who is logged in
    func getFeedUpdates(){
        
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

