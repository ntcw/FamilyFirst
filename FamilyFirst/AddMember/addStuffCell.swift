//
//  addStuffCell.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 04.07.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class addStuffCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.sizeToFit()
        detailsLabel?.sizeToFit()
        self.sizeToFit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
