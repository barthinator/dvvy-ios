//
//  ProfileViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProfileViewController: BaseViewController, UserModelDelegate, FeedModelDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource{

    //Reference to protocol UserModelDelegate, **dont manipulate value please
    var userQuery: [User] = []

    //Current user we are viewing
    var profileUser = User(first: "nil", last: "nil", uid: "nil")

    //Stores strings of uids for the current instance of the Profile
    var follows = ["nil", "nil"]
    var followings = ["nil", "nil"]

    //Stores the user information for the friends page
    var followers : [User] = []
    
    //Stores the feed user posts
    var feedPosts: [Post] = []


    @IBOutlet var imgProf: UIImageView!
    @IBOutlet var popUp: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    var isHidden = true
    var profileModel = UserModel.init()

    let storage = Storage.storage()

    //uid of the profile instance
    var uid : String = ""

    //Logged in user for reference when making follow decisions
    let loggedInUser = UserDefaults.standard.value(forKey:"currentUser") as! String

    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followersBtn: UIButton!
    
    let cellSpacingHeight: CGFloat = 5
    
    var userImage: UIImage = #imageLiteral(resourceName: "dvvyBtnImg")

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
        
        //The model
        super.feedModel.delegate = self
        super.feedModel.getUserCreatedPosts(uid: uid)
        
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
                self.userImage = UIImage(data: data!)!
                self.imgProf.image = self.userImage
                self.profileTableView.reloadData()
            }
        }

        //Set the data of the user
        profileTableView.backgroundColor = UIColor.white
        profileModel.delegate = self
        profileModel.getUser(uid: uid)
        profileModel.getFollowers(uid: uid)

        imgProf.isUserInteractionEnabled = true
        imgProf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
        // The table view delegate
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        //do this on all table views to remove highlighting
        profileTableView.register(UINib(nibName: "customFeedCell", bundle: nil), forCellReuseIdentifier: "cusFeedCell")
        
        //self.profileTableView.addSubview(self.refreshControl)
        
        configureTableView()
        
    }
    @objc func handleTap(){
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true)

    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.

        dismiss(animated: true, completion: nil)
    }



    @IBAction func showPopUp(_ sender: Any) {
        isHidden = !isHidden
        popUp.isHidden = isHidden

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
    
    //This loads the users feed posts from the feedModelDelegate
    func finishedLoading(_ posts: [Post]?) {
        feedPosts = posts!
        
        //reloads the profile data
        self.profileTableView.reloadData()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        imgProf.image = selectedImage

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //sections test
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedPosts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    //end
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusFeedCell", for: indexPath) as! customFeedCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        
        //cell.layer.cornerRadius = 60
        cell.feedNameLbl.text = feedPosts[indexPath.section].title
        cell.feedMessageTextView.text = feedPosts[indexPath.section].description
        
        cell.uid = feedPosts[indexPath.section].uid
        
        //This will have to wait until we figure out images
        cell.feedProfileImage.image = userImage
        cell.feedMessageView.layer.cornerRadius = 20
        cell.feedMessageView.layer.borderWidth = 1
        cell.feedMessageView.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        
        //buttons
        cell.btnDvvy.layer.cornerRadius = 10
        cell.btnLike.layer.cornerRadius = 10
        cell.btnOptions.layer.cornerRadius = 10
        
        
        return cell
    }

    
    func configureTableView(){
        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 120.0
    }
}
