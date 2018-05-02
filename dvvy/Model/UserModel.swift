//
//  UserModel.swift
//  dvvy
//
//  Created by David Bartholomew on 3/2/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase
import FirebaseStorage

struct User {
    var first: String
    var last: String
    var uid: String
}

protocol UserModelDelegate: class {
    func finishedLoading(user: User)
    func finishLoadingFollowers(followers: [String])
    func finishedLoadingFollowing(following: [String])
    var userQuery: [User] {get set}
}

class UserModel {
    
    var db: Firestore!
    var user = User(first: "nil", last: "nil", uid: "nil")
    weak var delegate: UserModelDelegate?
    var followers : [String] = []
    var following : [String] = []
    
    var users : [User] = []
    
    //TODO: Add some error handling to ensure the data is valid. Eg the phone number
    
    let storage = Storage.storage()
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    func setupUser(firstname : String, lastname: String, username: String, email: String, phoneNumber: String) {
        // [START add_ada_lovelace]
        // Add a new document with a generated ID
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document(uid!).setData([
            "firstname": firstname,
            "lastname": lastname,
            "username": username,
            "email": email,
            "phoneNumber": phoneNumber
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //When user is setup there username and value for being logged in is stored
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "currentUser")
        UserDefaults.standard.synchronize()
        
    }
    
    //Checks the UserDefault stored settings to see if the user is still logged in
    func isLoggedIn() -> Bool{
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    //Logs out the UserDefault settings
    func logout(){
        UserDefaults.standard.set(false, forKey:"isLoggedIn")
        UserDefaults.standard.set(nil, forKey:"currentUser")
        UserDefaults.standard.synchronize()
    }
    
    //Returns the current user id
    func getUID() -> String{
        if UserDefaults.standard.string(forKey: "currentUser") == nil {
            return (Auth.auth().currentUser?.uid)!
        }
        else{
            return UserDefaults.standard.string(forKey: "currentUser")!
        }
    }
    
    func getFollowers(uid: String){
        followers = []
        db.collection("users").document(uid).collection("followers").order(by: "datePosted").getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    self.followers.append(document.documentID)
                }
                self.delegate?.finishLoadingFollowers(followers: self.followers )
            }
        }
    }
    
    func getFollowing(uid: String){
        following = []
        db.collection("users").document(uid).collection("following").order(by: "datePosted").getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    self.following.append(document.documentID)
                }
                self.delegate?.finishedLoadingFollowing(following: self.following )
            }
        }
    }
    
    func follow(senderUID: String, recieverUID: String){
        //populate senderUID following collection with recieverUID
        db.collection("users").document(senderUID).collection("following").document(recieverUID).setData(
            ["datePosted": NSDate()]
        )
        
        //popoulate the recieverUID follower collection with senderUID
        db.collection("users").document(recieverUID).collection("followers").document(senderUID).setData(
            ["datePosted": NSDate()]
        )
        
    }

    func getUser(uid: String){
        db.collection("users").document(uid).getDocument {
           (document, err) in
            if let document = document {
                let dataDict = document.data()
                self.user = User(
                    first: dataDict!["firstname"] as! String,
                    last: dataDict!["lastname"] as! String,
                    uid: uid
            )} else {
                print("Document does not exist")
            }

            self.delegate?.finishedLoading(user: self.user)
        }
    }
    
    func getUserImage(uid: String){
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to download
        let imgProfRef = storageRef.child("userphotos/\(uid).jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imgProfRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
            } else {
                // Data for "userphotos/uid" is returned
                //self.delegate?.loadUserImage(userImage: UIImage(data: data!)!)
            }
        }
    }
    
    //Uses the UserModelDelegates userQuery variable to store multiple users by querying
    //many times depending upon how many ids are in the uids array
    func getUsers(uids: [String]){
        
        self.delegate?.userQuery = []
        
        for user in uids{
            var userStruct : User = User(first: "nil", last: "nil", uid: "nil")
            db.collection("users").document(user).getDocument {
                (document, err) in
                if let document = document {
                    let dataDict = document.data()
                    userStruct = User(
                        first: dataDict!["firstname"] as! String,
                        last: dataDict!["lastname"] as! String,
                        uid: user
                    )} else {
                    print("Document does not exist")
                }
                self.delegate?.userQuery.append(userStruct)
            }
        }
    }
    
    
}
