//
//  ChatViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 5/1/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

//
//  MessageViewController.swift
//  dvvy
//
//  Created by Keaka Kaakau on 18/ii/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class ChatViewController : BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, ChatModelDelegate, UserModelDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userQuery.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userQuery[row].first + userQuery[row].last
    }
    
    var userQuery: [User] = []
    
    
    //var time = "8:37pm"
    var userImage = #imageLiteral(resourceName: "David Bartholomew")
    
    var chats : [Chat] = []
    
    //
    var followings = ["nil", "nil"]
    
    var chatModel = ChatModel.init()
    var userModel = UserModel.init()
    
    @IBOutlet weak var chatCollection: UICollectionView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func createNewChat(_ sender: Any) {
        pickerView.reloadAllComponents()
        print(userQuery)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        chatCollection.delegate = self
        chatCollection.dataSource = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        chatModel.delegate = self
        userModel.delegate = self
        
        userModel.getFollowing(uid: UserDefaults.standard.value(forKey: "currentUser") as! String)
        chatModel.getChats(uid: UserDefaults.standard.value(forKey: "currentUser") as! String)
        
        chatCollection.allowsSelection = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chats.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let cellUID = cell.na
        
        let messageVC : MessageViewController = self.storyboard!.instantiateViewController(withIdentifier: "MessagesListed") as! MessageViewController
        //profVC.uid = cellUID!
        messageVC.messages = chats[indexPath.section].messages
        messageVC.chat = chats[indexPath.section]
        
        //Will push the new one with the users data
        self.navigationController!.pushViewController(messageVC, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Default sender cell
        let cell = chatCollection.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! ChatViewCell
        
        cell.name.text = "Chuck Norris"
        let currentUser = UserDefaults.standard.value(forKey: "currentUser") as! String
        if (currentUser != chats[indexPath.section].recieverID){
            cell.name.text = "Daniel Grissom"
        }
        cell.userImage.image = #imageLiteral(resourceName: "dvvyBtnImg")
        cell.lastMessageTime.text = "Click to open!"
        
        return cell
    }
    
    //User Delegate Methods
    func finishedLoading(user: User) {
        
    }
    
    func finishLoadingFollowers(followers: [String]) {
        
    }
    
    func finishedLoadingFollowing(following: [String]) {
        followings = following
        userModel.getUsers(uids: followings)
    }
    
    func finishedLoading(chats: [Chat]) {
        self.chats = chats
        chatCollection.reloadData()
        pickerView.reloadAllComponents()
    }
    
}

