//
//  SampleSwipeableCard.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit
import CoreMotion

class SampleSwipeableCard: SwipeableCardViewCard {
    
    @IBOutlet weak var messageLbl: UITextView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var listenBtn: UIButton!
    @IBOutlet weak var messageLblView: UIView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet private weak var imageBackgroundColorView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backgroundContainerView: UIView!
    
    /// Core Motion Manager
    private let motionManager = CMMotionManager()
    
    /// Shadow View
    private weak var shadowView: UIView?
    
    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0
    
    var viewModel: SampleSwipeableCellViewModel? {
        didSet {
            configure(forViewModel: viewModel)
        }
    }
    
    private func configure(forViewModel viewModel: SampleSwipeableCellViewModel?) {
        if let viewModel = viewModel {
            imageBackgroundColorView.backgroundColor = viewModel.color
            imageView.image = viewModel.image
            titleLabel.text = viewModel.title.uppercased()
            messageLbl.text = viewModel.description
            categoryLbl.text = viewModel.category
            
            backgroundContainerView.layer.cornerRadius = 14.0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageLblView.layer.cornerRadius = 20
        messageLblView.layer.borderWidth = 1
        messageLblView.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        
        listenBtn.layer.cornerRadius = 5
        
        configureShadow()
    }
    
    // MARK: - Shadow
    
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: SampleSwipeableCard.kInnerMargin,
                                              y: SampleSwipeableCard.kInnerMargin,
                                              width: bounds.width - (2 * SampleSwipeableCard.kInnerMargin),
                                              height: bounds.height - (2 * SampleSwipeableCard.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        
        // Roll/Pitch Dynamic Shadow
        //        if motionManager.isDeviceMotionAvailable {
        //            motionManager.deviceMotionUpdateInterval = 0.02
        //            motionManager.startDeviceMotionUpdates(to: .main, withHandler: { (motion, error) in
        //                if let motion = motion {
        //                    let pitch = motion.attitude.pitch * 10 // x-axis
        //                    let roll = motion.attitude.roll * 10 // y-axis
        //                    self.applyShadow(width: CGFloat(roll), height: CGFloat(pitch))
        //                }
        //            })
        //        }
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }
    
}
