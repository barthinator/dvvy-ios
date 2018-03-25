//
//  SubmitViewController.swift
//  dvvy
//
//  Created by Keaka Kaakau on 18/ii/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class SubmitViewController : BaseViewController {
    
    @IBOutlet var readyLbl: UILabel!
    @IBOutlet var checkBtn: UIButton!
    @IBOutlet var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        checkBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        checkBtn.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
        submitBtn.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
        
        checkBtn.layer.cornerRadius = 5
        submitBtn.layer.cornerRadius = 5
        readyLbl.layer.cornerRadius = 7
        
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
