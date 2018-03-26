//
//  FeedViewController.swift
//  dvvy
//
//  Created by David B on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var feedTableView: UITableView!

    //This is the Feed screen
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Do any additional setup after loading the view.
        feedTableView.layer.backgroundColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0).cgColor
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.register(UINib(nibName: "customFeedCell", bundle: nil), forCellReuseIdentifier: "cusFeedCell")
        
        configureTableView()        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusFeedCell", for: indexPath) as! customFeedCell
        
        let nameArray = ["Drea Driver", "Zack Goldstein", "Jason Kirschenmann", "Keaka Kaakau", "David Bartholomew", "Nathan Frasier"]
        
        cell.layer.cornerRadius = 20
        cell.feedNameLbl.text = nameArray[indexPath.row]
        cell.feedProfileImage.image = UIImage(named: nameArray[indexPath.row])
        cell.feedMessageView.layer.cornerRadius = 20
        cell.feedMessageView.layer.borderWidth = 1
        cell.feedMessageView.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func configureTableView(){
        feedTableView.rowHeight = UITableViewAutomaticDimension
        feedTableView.estimatedRowHeight = 120.0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Test
    

    
}
