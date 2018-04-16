//
//  ViewController.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class CardListingsViewController: UIViewController, SwipeableCardViewDataSource {
    
    
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeableCardView.dataSource = self
    }
    
}

// MARK: - SwipeableCardViewDataSource

extension CardListingsViewController {
    
    func numberOfCards() -> Int {
        return viewModels.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
}

extension CardListingsViewController {
    
    var viewModels: [SampleSwipeableCellViewModel] {
        
        let hamburger = SampleSwipeableCellViewModel(title: "dvvy",
                                                     color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "David Bartholomew"))
        
        let panda = SampleSwipeableCellViewModel(title: "dvvy",
                                                 color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "David Bartholomew"))
        
        let puppy = SampleSwipeableCellViewModel(title: "dvvy",
                                                 color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "David Bartholomew"))
        
        let poop = SampleSwipeableCellViewModel(title: "dvvy",
                                                color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0),
                                                image: #imageLiteral(resourceName: "David Bartholomew"))
        
        let robot = SampleSwipeableCellViewModel(title: "dvvy",
                                                 color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "David Bartholomew"))
        
        let clown = SampleSwipeableCellViewModel(title: "dvvy",
                                                 color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "David Bartholomew"))
        
        return [hamburger, panda, puppy, poop, robot, clown]
    }
    
}

