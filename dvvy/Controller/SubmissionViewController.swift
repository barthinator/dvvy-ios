//
//  SubmissionViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 4/25/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class SubmissionViewController: BaseViewController {
    
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var beHeardBtn: UIButton!
    
    var submitModel: SubmitModel?
    var submission: Submit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackModeBtn(collab: false)

        // Do any additional setup after loading the view.
        submitModel = SubmitModel.init()
        
        beHeardBtn.layer.cornerRadius = 7
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beHeard(_ sender: Any) {
        submission = Submit(
            uid: UserDefaults.standard.value(forKey: "currentUser") as! String,
            url: txtUrl.text!,
            name: "url"
        )
        submitModel?.makePost(post: self.submission!)
    }
    
}



