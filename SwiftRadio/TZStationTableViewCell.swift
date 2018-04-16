//
//  TZStationTableViewCell.swift
//  SwiftRadio
//
//  Created by tom on 2018/4/16.
//  Copyright © 2018年 matthewfecher.com. All rights reserved.
//

import UIKit

class TZStationTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configurationCell(station: RadioStation) {
        nameLabel.text = station.name
        descLabel.text = station.desc
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
