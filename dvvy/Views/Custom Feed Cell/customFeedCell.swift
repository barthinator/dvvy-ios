//
//  customFeedCell.swift
//  dvvy
//
//  Created by Zack Goldstein on 2/20/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class customFeedCell: UITableViewCell {

    @IBOutlet var feedNameLbl: UILabel!
    @IBOutlet var feedProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
