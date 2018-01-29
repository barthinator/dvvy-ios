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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !menuView.frame.contains(location) {
            openMenu()
        }
    }
    
    func openMenu() {
        if (menuShowing) {
            leadingConstraint.constant = -150
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else {
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        menuShowing = !menuShowing
    }

    @IBAction func openMenu(_ sender: Any) {
        openMenu()
    }

}

