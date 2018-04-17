//
//  ProfileViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit


class ProfileViewController: BaseViewController, UserModelDelegate{
    
    //Reference to protocol UserModelDelegate, **dont manipulate value please
    var userQuery: [User] = []
    
    //Current user we are viewing
    var profileUser = User(first: "nil", last: "nil", uid: "nil")
    
    //Stores strings of uids for the current instance of the Profile
    var follows = ["nil", "nil"]
    var followings = ["nil", "nil"]
    
    //Stores the user information for the friends page
    var followers : [User] = []

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    var isHidden = true
    var profileModel = UserModel.init()
    
    //uid of the profile instance
    var uid : String = ""
    
    //Logged in user for reference when making follow decisions
    let loggedInUser = UserDefaults.standard.value(forKey:"currentUser") as! String
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followersBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calls the slide menu button
        addSlideMenuButton()
        
        followersBtn.layer.borderWidth = 1
        followersBtn.layer.cornerRadius = 5
        followersBtn.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        
        //Checks if string is empty , if so then the currentUser is added to the id
        if uid.isEmpty {
            uid = UserDefaults.standard.value(forKey: "currentUser") as! String
        }
        
        
        profileTableView.backgroundColor = UIColor.darkGray
        profileModel.delegate = self
        profileModel.getUser(uid: uid)
        profileModel.getFollowers(uid: uid)
        profileModel.getFollowing(uid: uid)
    }
    
    //when the follow button is tapped
    @IBAction func followPressed(_ sender: Any) {
        //Checks to see if the current profile isntance of user is the same as the logged in user
        if (uid == UserDefaults.standard.value(forKey:"currentUser") as! String) {
            followBtn.setTitle("NOPE", for: UIControlState.normal)
        }
        else{
            //If already following the user, thens setTitle if not already
            if (follows.contains(loggedInUser)) {
                followBtn.setTitle("FOLLOWED", for: UIControlState.normal)
            }
            else{
                followBtn.setTitle("FOLLOWED", for: UIControlState.normal)
                profileModel.follow(senderUID: loggedInUser, recieverUID: uid)
                profileModel.getFollowers(uid: uid)
            }
        }
    }
    
    //Overrides the destination if it is the friends view controller to pass it follower data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is FriendsViewController
        {
            let vc = segue.destination as? FriendsViewController
            
            //Passes in follower data and uid of class to pass back later
            vc?.followers = userQuery
            vc?.uid = uid
        }
    }
    
    
    func finishedLoading(user: User) {
        profileUser = user
        usernameLabel.text = profileUser.first + " " + profileUser.last
    }
    
    func finishLoadingFollowers(followers: [String]) {
        follows = followers
        
        if (follows.contains(loggedInUser)) {
            followBtn.setTitle("FOLLOWED", for: UIControlState.normal)
        }
        profileModel.getUsers(uids: follows)
    }

    func finishedLoadingFollowing(following: [String]) {
        followings = following
    }
    
    
}

