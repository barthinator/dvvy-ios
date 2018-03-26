//
//  TermsViewController.swift
//  
//
//  Created by Zack Goldstein on 3/26/18.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet var agreeBtn: UIButton!
    @IBOutlet var disagreeBtn: UIButton!
    @IBOutlet var termsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        agreeBtn.layer.cornerRadius = 9
        disagreeBtn.layer.cornerRadius = 9
        
        termsView.layer.masksToBounds = true
        termsView.layer.cornerRadius = 12
        termsView.layer.borderWidth = 3
        termsView.layer.borderColor = UIColor.black.cgColor
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
