//
//  ChatModel.swift
//  dvvy
//
//  Created by Nathan Frasier on 4/11/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//
import Firebase

struct Chat {
    var messages: [Message]
    var currentUser: String
}

struct Message {
    var recieverID: String
    var senderID: String
    var message: String
}

protocol ChatModelDelegate: class {
    func finishedLoading(chat: Chat)
}

class ChatModel {
    
    var db: Firestore!
    weak var delegate: ChatModelDelegate?
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    
}
