//
//  BottomBar.swift
//  dvvy
//
//  Created by David Bartholomew on 2/11/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class BottomNavController : UINavigationController {
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = CGFloat(100)
        
        
        //TO DO: Figure out why there is a slight offset when trying to put a nav bar at bottom
        //TO DO 2: Figure out how to make the bar go behind the menu
        //TO DO 3: Style it
        navigationBar.frame = CGRect(x: 0, y: view.frame.height-height/2+6, width: view.frame.width, height: height)
        navigationBar.tintColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
        navigationBar.barTintColor = UIColor(red:0.95, green:0.45, blue:0.38, alpha:1.0)
    }
    
}
