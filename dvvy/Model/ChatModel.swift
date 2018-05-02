//
//  ChatModel.swift
//  dvvy
//
//  Created by Nathan Frasier on 4/11/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//
import Firebase

struct Chat {
    var recieverID: String
    var senderID: String
    var messages: [Message]
}

struct Message {
    var message: String
    var dateSent: String
}

protocol ChatModelDelegate: class {
    func finishedLoading(chat: Chat)
}

class ChatModel {
    
    var db: Firestore!
    weak var delegate: ChatModelDelegate?
    
    var messages: [Message] = []
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func getChat(){
        //idk
    }
    
    func get(recieverID: String, senderID: String){
        //Need to figure out how we know the chatID
        db.collection("conversation").document("idk").collection("messages").getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
    
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    let messageData = Message(message: data["message"] as! String, dateSent: data["timestamp"] as! String)
                    self.messages.append(messageData)
                    
                }
                self.delegate?.finishedLoading(chat: Chat(recieverID: recieverID, senderID: senderID, messages: self.messages))
            }
        }
    }
    
}
