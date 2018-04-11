//
//  ProfileViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UserModelDelegate{
    
    var profileUser = User(first: "nil", last: "nil")
    @IBOutlet var friendsBtn: UIButton!
    
    @IBOutlet var popUp: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    var isHidden = true
    var profileModel = UserModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calls the slide menu button
        addSlideMenuButton()
        friendsBtn.layer.borderWidth = 1
        friendsBtn.layer.cornerRadius = 5
        friendsBtn.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        //Set the data of the user
        
        
        profileTableView.backgroundColor = UIColor.darkGray
        profileModel.delegate = self
        profileModel.getUser(uid: UserDefaults.standard.value(forKey: "currentUser") as! String)
    }
    

    @IBAction func showPopUp(_ sender: Any) {
        isHidden = !isHidden
        popUp.isHidden = isHidden
        
    }
    
    func finishedLoading(user: User) {
        profileUser = user
        print(profileUser)
        usernameLabel.text = profileUser.first + " " + profileUser.last
    }
    
}

