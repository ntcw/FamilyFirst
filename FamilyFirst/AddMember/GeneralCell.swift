//
//  GeneralCell.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 08.07.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class GeneralCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear

        textLabel?.textColor = .white
        detailTextLabel?.textColor = .white

        if reuseIdentifier == "CellWithTextField" {
            selectionStyle = .none
        } else {
            let bg = UIView()
            bg.backgroundColor = UIColor(displayP3Red: 194, green: 201, blue: 204, alpha: 0.3)

            selectedBackgroundView = bg
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
