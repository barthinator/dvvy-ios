//
//  MessageViewController.swift
//  dvvy
//
//  Created by Keaka Kaakau on 18/ii/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class MessageViewController : BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var messageCollection: UICollectionView!
    
    
    @IBOutlet weak var messageBox: UITextField!
    
    @IBOutlet weak var sendMessage: UIButton!
    
    var message = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var messages = ["This is a test message", "That is very cool", "what is up", "how is it going","This is a test message", "That is very cool", "what is up", "how is it going","This is a test message", "That is very cool", "what is up", "how is it going","This is a test message", "That is very cool", "what is up", "how is it going"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        
        messageCollection.delegate = self
        messageCollection.dataSource = self
        
        //messageBox.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        message = messageBox.text!
        messages.append(message)
        
        messageCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Default sender cell
        var cell = messageCollection.dequeueReusableCell(withReuseIdentifier: "senderMessage", for: indexPath) as! MessageViewCell
        
        cell.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 20
        
        if indexPath.row == 1{
            //Recipient cell, need to mark these somehow
            cell = messageCollection.dequeueReusableCell(withReuseIdentifier: "recipientMessage", for: indexPath) as! MessageViewCell
            
            cell.layer.borderColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0).cgColor
            cell.layer.borderWidth = 1.5
            cell.layer.cornerRadius = 20
        }
        
        
        cell.messageLbl.text = messages[indexPath.row]
        
        
        
        return cell
    }
}
