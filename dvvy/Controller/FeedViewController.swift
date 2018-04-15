//
//  FeedViewController.swift
//  dvvy
//
//  Created by David B on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: BaseViewController, UITableViewDelegate, FeedModelDelegate, UITableViewDataSource {
    
    //Creates the feed data class and delegate connection
    var allPosts: [Post] = []

    @IBOutlet var feedTableView: UITableView!
    let cellSpacingHeight: CGFloat = 5
    let nameArray = ["Drea Driver", "Zack Goldstein", "Jason Kirschenmann", "Keaka Kaakau", "David Bartholomew", "Nathan Frasier"]
    
    //Makes the refresh happen when pulled down
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0)
        
        return refreshControl
    }()
    
    //Used for when refreshed is called, need to query the data here too
    @objc func refreshTable(_ refreshControl: UIRefreshControl){
        super.feedModel.getFeedUpdates()
        self.feedTableView.reloadData()
        refreshControl.endRefreshing()
    }

    func finishedLoading(_ posts: [Post]?) {
        
        //Grabs the data passed in from the model class and then puts it in the allPosts array
        allPosts = posts!
        
        //Reloads the data after it is all fetched
        self.feedTableView.reloadData()
        
    }
    
    
    //This is the Feed screen
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        //The model
        super.feedModel.delegate = self
        super.feedModel.getFeedUpdates()

        // The table view delegate
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        //do this on all table views to remove highlighting
        feedTableView.allowsSelection = false
        feedTableView.register(UINib(nibName: "customFeedCell", bundle: nil), forCellReuseIdentifier: "cusFeedCell")
        self.feedTableView.addSubview(self.refreshControl)

        configureTableView()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    //sections test
    func numberOfSections(in tableView: UITableView) -> Int {
        return allPosts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    //end

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusFeedCell", for: indexPath) as! customFeedCell

        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true

        //cell.layer.cornerRadius = 60
        cell.feedNameLbl.text = allPosts[indexPath.section].title
        cell.feedMessageTextView.text = allPosts[indexPath.section].description
        //This will have to wait until we figure out images
        //cell.feedProfileImage.image = UIImage(named: nameArray[indexPath.section])
        cell.feedMessageView.layer.cornerRadius = 20
        cell.feedMessageView.layer.borderWidth = 1
        cell.feedMessageView.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor

        //buttons
        cell.btnDvvy.layer.cornerRadius = 10
        cell.btnLike.layer.cornerRadius = 10
        cell.btnOptions.layer.cornerRadius = 10


        return cell
    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return 6
//    }

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
