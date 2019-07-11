//
//  DatePickerCell.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 20.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear

        textLabel?.textColor = .white
        detailTextLabel?.textColor = .white

        let bg = UIView()
        bg.backgroundColor = UIColor(displayP3Red: 194, green: 201, blue: 204, alpha: 0.3)
        selectedBackgroundView = bg
        detailTextLabel?.text = getDate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func getDate() -> String {
        let date = Date() - (20 * 365 * 24 * 60 * 60)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat.string(from: date)
    }
}
