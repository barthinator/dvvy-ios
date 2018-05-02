//
//  ChatModel.swift
//  dvvy
//
//  Created by Nathan Frasier on 4/11/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//
import Firebase

struct Chat {
    var id: String
    var recieverID: String
    var senderID: String
    var messages: [Message]
}

struct Message {
    var message: String
    var dateSent: Date
    var senderID: String
}

protocol ChatModelDelegate: class {
    func finishedLoading(chats: [Chat])
}

class ChatModel {
    
    var db: Firestore!
    weak var delegate: ChatModelDelegate?
    
    var messages: [Message] = []
    var chats: [Chat] = []
    
    var isReciever = false
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func sendMessage(chatID: String, senderID: String, message: String){
        
        db.collection("conversation").document(chatID).collection("messages").addDocument(data: [
            "message": message,
            "senderID": senderID,
            "timestamp": Date()
            ])
        
    }
    
    func getChat(id: String){
        
    }
    
    func getChats(uid: String){
        self.chats = []
        db.collection("conversation").whereField("senderID", isEqualTo: uid).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print(err)
            }
            else{
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.getMessages(chatID: document.documentID, senderID: data["senderID"] as! String, recieverID: data["recieverID"] as! String)
                }
            }
            self.isReciever = false
        }
        db.collection("conversation").whereField("recieverID", isEqualTo: uid).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print(err)
            }
            else{
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.getMessages(chatID: document.documentID, senderID: data["senderID"] as! String, recieverID: data["recieverID"] as! String)
                }
            }
            self.isReciever = true
        }
    }
    
    func getMessages(chatID: String, senderID: String, recieverID: String){
        //Need to figure out how we know the chatID
        db.collection("conversation").document(chatID).collection("messages").order(by: "timestamp").getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                
                self.messages = []
    
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    let messageData = Message(message: data["message"] as! String, dateSent: data["timestamp"] as! Date, senderID: data["senderID"] as! String)
                    self.messages.append(messageData)
                    
                }
                
                let chatData = Chat(id: chatID, recieverID: recieverID, senderID: senderID, messages: self.messages)
                self.chats.append(chatData)
            }
            self.delegate?.finishedLoading(chats: self.chats)
        }
    }
    
}
