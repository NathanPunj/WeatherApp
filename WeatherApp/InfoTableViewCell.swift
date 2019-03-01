//
//  InfoTableViewCell.swift
//  WeatherApp
//
//  Created by Nathan Sharma on 27/02/2019.
//  Copyright © 2019 Nathan Sharma. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "InfoTableViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
