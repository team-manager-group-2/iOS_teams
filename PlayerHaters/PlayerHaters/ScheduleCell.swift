//
//  ScheduleCell.swift
//  PlayerHaters
//
//  Created by Michael McChesney on 3/8/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventStatus: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
