//
//  CustomLisitingCell.swift
//  dvvy
//
//  Created by Jason Kirschenmann on 3/12/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

class customListingCell: UITableViewCell {

    @IBOutlet var imageListing: UIImageView!
    @IBOutlet var lblNameListing: UILabel!
    @IBOutlet var lblNeedTypeCollab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
