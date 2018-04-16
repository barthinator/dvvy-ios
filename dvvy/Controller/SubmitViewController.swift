//
//  SubmitViewController.swift
//  dvvy
//
//  Created by Keaka Kaakau on 18/ii/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class SubmitViewController : BaseViewController {
    
    
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        super.viewDidLoad()
        //Calls the slide menu button
        addSlideMenuButton()
        btnSubmit.layer.borderWidth = 1
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        btnCheck.layer.borderWidth = 1
        btnCheck.layer.cornerRadius = 5
        //btnCheck.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        
        
        
        
        // Do any additional setup after loading the view.
        //readyLbl.layer.cornerRadius = 15
//
//        submitBtn.layer.borderWidth = 1
//        submitBtn.layer.cornerRadius = 5
//        submitBtn.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
}
