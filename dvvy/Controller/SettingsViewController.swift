//
//  SettingsViewController.swift
//  dvvy
//
//  Created by Nathan Frasier on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class SettingsViewController : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var General: UIButton!
    @IBOutlet weak var Profile: UIButton!
    @IBOutlet weak var Account: UIButton!
    @IBOutlet weak var Friends: UIButton!
    @IBOutlet weak var Support: UIButton!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
}




