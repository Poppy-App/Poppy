//
//  ListingCell.swift
//  Poppy
//
//  Created by Avi Patel on 4/3/22.
//

import UIKit

class ListingCell: UITableViewCell {
    @IBOutlet weak var randLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
