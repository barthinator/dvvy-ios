//
//  UserModel.swift
//  dvvy
//
//  Created by David Bartholomew on 3/2/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase

class UserModel {
    
    var db: Firestore!
    
    //TODO: Add some error handling to ensure the data is valid. Eg the phone number
    
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

    func getProfileName()  {
        var firstname : String = "empty"
        db.collection("users").document(getUID()).getDocument{
            (document, err) in
            if let document = document {
                let dataDict = document.data()
                firstname = dataDict!["firstname"] as! String
            } else {
                print("Document does not exist")
                firstname = "we messed up..."
            }
        }
    }
}
