//
//  CollabViewController.swift
//  dvvy
//
//  Created by David B on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class CollabViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CollabModelDelegate {
    
    var allPosts: [CollabPost] = []
    
    @IBOutlet weak var collabTableView: UITableView!
    let cellSpacingHeight: CGFloat = 5
    let nameArray = ["Drea Driver", "Zack Goldstein", "Jason Kirschenmann", "Keaka Kaakau", "David Bartholomew", "Nathan Frasier", "Drea Driver", "Zack Goldstein", "Jason Kirschenmann", "Keaka Kaakau", "David Bartholomew", "Nathan Frasier"]
    let needArray = ["guitar", "piano", "composition", "producer", "drums", "violin", "guitar", "piano", "composition", "producer", "drums", "violin"]
    
    let collabModel = CollabModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        collabModel.delegate = self
        collabModel.getCollabUpdates()

        collabTableView.delegate = self
        collabTableView.dataSource = self

        collabTableView.allowsSelection = false

        collabTableView.register(UINib(nibName: "customListingCell", bundle: nil), forCellReuseIdentifier: "cusListCell")
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    func finishedLoading(_ posts: [CollabPost]?) {
        
        //Grabs the data passed in from the model class and then puts it in the allPosts array
        allPosts = posts!
        
        //Reloads the data after it is all fetched
        self.collabTableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusListCell", for: indexPath) as! customListingCell

        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true

        //cell.layer.cornerRadius = 60
        cell.lblNameListing.text = allPosts[indexPath.section].name.uppercased()
        //cell.imageListing.image = UIImage(named: nameArray[indexPath.section])
        cell.lblNeedTypeCollab.text = allPosts[indexPath.section].category.lowercased()

        return cell
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Trying to add david to the user model with the button
    @IBAction func addDavid(_ sender: Any) {
    }


    func configureTableView(){
        collabTableView.rowHeight = UITableViewAutomaticDimension
        collabTableView.estimatedRowHeight = 120.0
    }
    //test comments

}
