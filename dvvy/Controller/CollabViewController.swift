//
//  CollabViewController.swift
//  dvvy
//
//  Created by David B on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class CollabViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collabTableView: UITableView!
    let cellSpacingHeight: CGFloat = 5
    let nameArray = ["Drea Driver", "Zack Goldstein", "Jason Kirschenmann", "Keaka Kaakau", "David Bartholomew", "Nathan Frasier"]
    let needArray = ["guitar", "piano", "composition", "producer", "drums", "violin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        collabTableView.delegate = self
        collabTableView.dataSource = self
        
        collabTableView.allowsSelection = false
        
        collabTableView.register(UINib(nibName: "customListingCell", bundle: nil), forCellReuseIdentifier: "cusListCell")
        configureTableView()

        
        
        collabTableView.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //sections test
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
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
        cell.lblNameListing.text = nameArray[indexPath.section].uppercased()
        cell.imageListing.image = UIImage(named: nameArray[indexPath.section])
        cell.lblNeedTypeCollab.text = needArray[indexPath.section].lowercased()
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureTableView(){
        collabTableView.rowHeight = UITableViewAutomaticDimension
        collabTableView.estimatedRowHeight = 120.0
    }
    //test comments
    
}

