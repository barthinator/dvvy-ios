//
//  ProfileViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UserModelDelegate, UIImagePickerControllerDelegate{
    
    
    var profileUser = User(first: "nil", last: "nil")
    var follows = ["nil", "nil"]
    @IBOutlet var friendsBtn: UIButton!
    
    @IBOutlet var imgProf: UIImageView!
    @IBOutlet var popUp: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    var isHidden = true
    var profileModel = UserModel.init()
    var uid = UserDefaults.standard.value(forKey: "currentUser")
    
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
        profileModel.getUser(uid: uid as! String)
        profileModel.getFollowers(uid: uid as! String)
        
        
        
        imgProf.isUserInteractionEnabled = true
        imgProf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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
        
    }
    
    func finishedLoading(user: User) {
        profileUser = user
        usernameLabel.text = profileUser.first + " " + profileUser.last
        print(user)
    }
    
    func finishLoadingFollowers(followers: [String]) {
        follows = followers
        print(follows)
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
}

