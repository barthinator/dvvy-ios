//
//  customFeedCell.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/20/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class customFeedCell: UITableViewCell {

    @IBOutlet var btnDvvy: UIButton!
    @IBOutlet var btnOptions: UIButton!
    @IBOutlet var btnLike: UIButton!
    
    @IBOutlet var feedMessageTextView: UITextView!
    @IBOutlet var feedMessageView: UIView!
    @IBOutlet var feedNameLbl: UILabel!
    @IBOutlet var feedProfileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
