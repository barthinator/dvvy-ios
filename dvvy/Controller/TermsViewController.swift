//
//  TermsViewController.swift
//  dvvy
//
//  Created by Jason Kirschenmann on 4/15/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit


class TermsViewController: BaseViewController {
    @IBOutlet var txtView: UITextView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        super.viewDidLoad()
        //Calls the slide menu button
        addSlideMenuButton()
        txtView.layer.borderWidth = 2
        txtView.layer.cornerRadius = 5
        txtView.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        
        backBtn.layer.cornerRadius = 7
        agreeBtn.layer.cornerRadius = 7
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
