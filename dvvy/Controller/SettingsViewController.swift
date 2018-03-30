//
//  SettingsViewController.swift
//  dvvy
//
//  Created by Nathan Frasier on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func handleLogout(_ sender: Any) {
        //Need to implement something that sets the value to false for signed in user here
        self.navigationController?.isNavigationBarHidden = true
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
}




