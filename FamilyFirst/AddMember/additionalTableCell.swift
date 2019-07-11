//
//  AdditionalTableCell.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 05.07.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class AdditionalTableCell: UITableViewCell {
    var additional: String? {
        didSet {
            titleLabel.text = additional
        }
    }

    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#C2C9CC", alpha: 0.3)

        view.layer.cornerRadius = 10
        return view
    }()

    public let titleLabel: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .white

        lbl.font = UIFont(name: "KohinoorTelugu-Medium", size: 17)
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(cellView)
        textLabel?.text = additional

        cellView.addSubview(titleLabel)

        selectionStyle = .none

        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: true)

        titleLabel.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: nil, right: cellView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0, enableInsets: false)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
