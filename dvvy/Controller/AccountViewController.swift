//
//  AccountViewController.swift
//  dvvy
//
//  Created by Nathan Frasier on 2/19/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func handleLogout(_ target: UIButton) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: false, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
}

