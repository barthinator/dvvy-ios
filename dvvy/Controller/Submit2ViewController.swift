//
//  Submit2ViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 3/26/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class Submit2ViewController: UIViewController {

    @IBOutlet var ready2Lbl: UILabel!
    @IBOutlet var check2Btn: UIButton!
    @IBOutlet var submit2Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        submit2Btn.layer.borderWidth = 2
        submit2Btn.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor

        check2Btn.titleLabel?.textAlignment = NSTextAlignment.center
        
        check2Btn.layer.cornerRadius = 9
        submit2Btn.layer.cornerRadius = 9
        
        ready2Lbl.layer.masksToBounds = true
        ready2Lbl.layer.cornerRadius = 12
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
