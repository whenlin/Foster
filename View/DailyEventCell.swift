//
//  DailyEventCell.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-30.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class DailyEventCell: UITableViewCell {

    @IBOutlet weak var weekDay: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
