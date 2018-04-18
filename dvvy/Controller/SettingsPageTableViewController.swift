//
//  SettingsPageTableViewController.swift
//  
//
//  Created by Zack Goldstein on 4/18/18.
//

import UIKit
import Firebase

class SettingsPageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLogout(_ sender: Any) {
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
    

    

}
class SettingsPageBaseViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
    }
    
}
