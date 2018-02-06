//
//  ViewController.swift
//  dvvy
//
//  Created by David Bartholomew on 1/28/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    //If anywhere is touched outside the menu, it closes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Makes sure that the menu is showing so it doesn't toggle
        //when it is not showing
        if (menuShowing){
            let touch = touches.first
            guard let location = touch?.location(in: self.view) else { return }
            if !menuView.frame.contains(location) {
                openMenu()
            }
        }
    }
    
    //This is the function that will change the leading constraint
    //option to allow the sidebar to open.
    func openMenu() {
        if (menuShowing) {
            leadingConstraint.constant = -150
            
            //Creates the sliding animation
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else {
            leadingConstraint.constant = 0
            
            //Creates the sliding animation
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        //Switches the global boolean
        menuShowing = !menuShowing
    }

    //The actual outlet for the menu button
    @IBAction func openMenu(_ sender: Any) {
        openMenu()
    }

}

