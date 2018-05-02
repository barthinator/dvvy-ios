//
//  PortfolioController.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/17/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//
import UIKit
class PortfolioController : BaseViewController  {
    
    var portfolioModel: PortfolioModel?
    var portfolio: Portfolio?
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var txtUrl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        submitBtn.layer.cornerRadius = 7
        
        super.viewDidLoad()
        portfolioModel = PortfolioModel.init()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func submit(_ sender: Any) {
        portfolio = Portfolio(
            uid: UserDefaults.standard.value(forKey: "currentUser") as! String,
            url: txtUrl.text!,
            name: UserDefaults.standard.value(forKey: "name") as! String
        )
        portfolioModel?.makePost(post: self.portfolio!)
    }
}
