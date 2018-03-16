//
//  FeedModelController.swift
//  dvvy
//
//  Created by Nathan Frasier on 3/15/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Foundation
import Firebase

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

struct FeedModel {
    var user: String
    var songLink: String
    var description: String
    var category: String
    var timeStamp: Date
    
    var dictionary:[String:Any] {
        return [
            "user":user,
            "songLink": songLink,
            "description": description,
            "category": category,
            "timeStamp": timeStamp
        ]
    }
}

//extension Feed : DocumentSerializable {
//    init?(dictionary: [String:Any]) {
//        guard let user = dictionary["name"] as? String,
//        let songLink = dictionary["songLink"] as? String,
//        let description = dictionary["description"] as? String,
//        let category = dictionary["category"] as? String,
//        let timeStamp = dictionary["timeStamp"] as? Date
//    }
//}

