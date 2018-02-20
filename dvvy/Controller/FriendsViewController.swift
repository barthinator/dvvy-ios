//
//  FriendsViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        friendsTableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "customFriendCell")
        
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFriendCell", for: indexPath) as! customFriendCell
        
        let nameArray = ["Zack", "Drea", "Jason", "Keaka", "David", "Nathan"]
        
        cell.nameLbl.text = nameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func configureTableView(){
        friendsTableView.rowHeight = UITableViewAutomaticDimension
        friendsTableView.estimatedRowHeight = 120.0
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
