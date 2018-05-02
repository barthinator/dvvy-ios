//
//  FriendsViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class FriendsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var friendsTableView: UITableView!
    var followers : [User] = []
    var uid : String = "nil"
    
    var allImages : [String: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        friendsTableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "cusFriendCell")
        
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusFriendCell", for: indexPath) as! customFriendCell
        
        cell.layer.cornerRadius = 20
        cell.nameLbl.text = followers[indexPath.row].first + " " + followers[indexPath.row].last
        cell.profileImage.image = allImages[followers[indexPath.row].uid] ?? #imageLiteral(resourceName: "David Bartholomew")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    //Makes sure the uid is passed back to load the user that was there
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ProfileViewController
        {
            let vc = segue.destination as? ProfileViewController
            vc?.uid = uid
        }
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
