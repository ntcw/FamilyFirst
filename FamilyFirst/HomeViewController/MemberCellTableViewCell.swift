//
//  MemberCellTableViewCell.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class MemberCellTableViewCell: UITableViewCell {
    @IBOutlet var memberPicture: UIImageView!
    @IBOutlet var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
