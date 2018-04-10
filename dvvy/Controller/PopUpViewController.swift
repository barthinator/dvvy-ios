//
//  PopUpViewController.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/18/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnCreate : UIButton!
    
    /**
     *  Delegate of the MenuVC
     */
    var delegate : PopUpDelegate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOpacity = 1
        popUpView.layer.shadowOffset = CGSize.zero
        popUpView.layer.shadowRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
