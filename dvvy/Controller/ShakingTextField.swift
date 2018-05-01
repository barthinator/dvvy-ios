//
//  ShakingTextField.swift
//  dvvy
//
//  Created by Zack Goldstein on 4/30/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: center.y))
        
        self.layer.add(animation, forKey: "position")
    }

}
