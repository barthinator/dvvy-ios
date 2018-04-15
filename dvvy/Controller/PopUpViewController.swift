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
    
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOpacity = 1
        popUpView.layer.shadowOffset = CGSize.zero
        popUpView.layer.shadowRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissPopup() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func makePost(_ sender: Any) {
        let post = CollabPost(
            uid: UserDefaults.standard.value(forKey: "currentUser") as! String,
            description: descriptionField.text,
            title: categoryField.text!,
            datePosted: Date(),
            category: categoryField.text!,
            name: "test"
        )
        
        collabModel?.makePost(post: post)
        dismissPopup()
    }
    
    
}
