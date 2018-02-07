//
//  CollabViewController.swift
//  dvvy
//
//  Created by David B on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class CollabViewController: BaseViewController {
    
    @IBOutlet weak var collabTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        collabTableView.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //test comments
    
}

