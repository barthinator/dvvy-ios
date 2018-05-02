//
//  PopUpViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnCreate : UIButton!
    
    /**
     *  Delegate of the MenuVC
     */
    var delegate : PopUpDelegate?
    
    var collabModel : CollabModel?
    
    var feedModel: FeedModel?
    
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var feedButton: UIButton!
    
    @IBOutlet weak var collabButton: UIButton!
    
    var feedPost: Post?
    
    var collabPost: CollabPost?
    
    var state = "Feed"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOpacity = 1
        popUpView.layer.shadowOffset = CGSize.zero
        popUpView.layer.shadowRadius = 10
        
        setFeedActive()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissPopup() {
        let viewMenuBack : UIView = view.subviews.last!
        
        //Need to figure out how to change menu bar items tag to 0
        
        //This triggers an animation to close the popup
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            var frameMenu : CGRect = viewMenuBack.frame
            frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
            viewMenuBack.frame = frameMenu
            viewMenuBack.layoutIfNeeded()
            viewMenuBack.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            viewMenuBack.removeFromSuperview()
        })
    }
    
    //Sets the visual feed as active
    func setFeedActive() {
        categoryField.text = "Title"
        descriptionField.text = "Feed Description"
        
        feedButton.layer.cornerRadius = 5
        feedButton.layer.borderWidth = 2
        feedButton.layer.borderColor = UIColor.red.cgColor
        
        collabButton.layer.cornerRadius = 0
        collabButton.layer.borderWidth = 0
        collabButton.layer.borderColor = UIColor.red.cgColor
        
        self.state = "Feed"
    }
    
    //Sets the visual collab as active
    func setCollabActive() {
        categoryField.text = "Category"
        descriptionField.text = "Collab Description"
        
        collabButton.layer.cornerRadius = 5
        collabButton.layer.borderWidth = 2
        collabButton.layer.borderColor = UIColor.red.cgColor
        
        feedButton.layer.cornerRadius = 0
        feedButton.layer.borderWidth = 0
        feedButton.layer.borderColor = UIColor.red.cgColor
        
        self.state = "Collab"
    }
    
    
    @IBAction func setFeedState(_ sender: Any) {
        setFeedActive()
    }
    
    
    @IBAction func setCollabState(_ sender: Any) {
        setCollabActive()
    }
    
    @IBAction func makePost(_ sender: Any) {
        switch(state){
            case "Feed":
                feedPost = Post(
                    uid: UserDefaults.standard.value(forKey: "currentUser") as! String,
                    description: descriptionField.text!,
                    title: categoryField.text!,
                    userImage: #imageLiteral(resourceName: "dvvyBtnImg"),
                    datePosted: Date()
                )
                feedModel?.makePost(post: self.feedPost!)
            case "Collab":
                collabPost = CollabPost(
                    uid: UserDefaults.standard.value(forKey: "currentUser") as! String,
                    description: descriptionField.text,
                    title: categoryField.text!,
                    datePosted: Date(),
                    category: categoryField.text!,
                    userImage: #imageLiteral(resourceName: "dvvyBtnImg"),
                    name: UserDefaults.standard.value(forKey: "name") as! String
                )
                collabModel?.makePost(post: self.collabPost!)
            default: break
        }
        dismissPopup()
    }
    
    
}
