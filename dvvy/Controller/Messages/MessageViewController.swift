//
//  MessageViewController.swift
//  dvvy
//
//  Created by Keaka Kaakau on 18/ii/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class MessageViewController : BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, ChatModelDelegate {
    
    func finishedLoading(chats: [Chat]) {
        for c in chats{
            if c.id == chat.id{
                messages = c.messages
                messageCollection.reloadData()
            }
        }
    }
    
    @IBOutlet weak var messageCollection: UICollectionView!
    
    var chatModel : ChatModel = ChatModel.init()
    
    @IBOutlet weak var messageBox: UITextField!
    
    @IBOutlet weak var sendMessage: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var chat : Chat = Chat(id: "null", recieverID: "null", senderID: "null", messages: [])
    
    var messages : [Message] = []
    
    
    //The timer stuff needs to go to be able to implement real time
    var timer = Timer()
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        chatModel.getChats(uid: UserDefaults.standard.value(forKey: "currentUser") as! String)
        print("get messages")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        chatModel.delegate = self
        
        messageCollection.delegate = self
        messageCollection.dataSource = self
        
        //messageBox.becomeFirstResponder()
        // Do any additional setup after loading the view.
        scheduledTimerWithTimeInterval()
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        let message : Message = Message(message: messageBox.text!, dateSent: Date(), senderID: UserDefaults.standard.value(forKey: "currentUser") as! String)
        
        chatModel.sendMessage(chatID: chat.id, senderID: UserDefaults.standard.value(forKey: "currentUser") as! String, message: message.message)
        
        messages.append(message)
        
        messageBox.text = ""
        
        messageCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentUser = UserDefaults.standard.value(forKey: "currentUser") as! String
        
        let isOwnerCell = messages[indexPath.row].senderID == currentUser

        var cell = messageCollection.dequeueReusableCell(withReuseIdentifier: "senderMessage", for: indexPath) as! MessageViewCell
        
        if isOwnerCell {
            cell.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
            cell.layer.borderWidth = 1.5
            cell.layer.cornerRadius = 20
        } else {
            //Recipient cell, need to mark these somehow
            cell = messageCollection.dequeueReusableCell(withReuseIdentifier: "recipientMessage", for: indexPath) as! MessageViewCell
            
            cell.layer.borderColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0).cgColor
            cell.layer.borderWidth = 1.5
            cell.layer.cornerRadius = 20
        }
        
        cell.messageLbl.text = messages[indexPath.row].message
        
        return cell
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
}
