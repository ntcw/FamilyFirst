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
        // Initialization code
        detailTextLabel?.text = getDate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getDate() ->String{
        let date = Date() - (20*365*24*60*60)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat.string(from: date)
    }

}
