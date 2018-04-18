//
//  SettingsTableViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 4/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import Firebase

class SettingsTableViewController: UITableViewController {

    @IBOutlet var settingsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // I see you only have 1 section now
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //you should return appropriate number
        return 8
    }

    // MARK: - Table view data source
    
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

    

//    class SettingsTableViewControllerMenu: BaseViewController {
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            addSlideMenuButton()
//        }
//    }
}
