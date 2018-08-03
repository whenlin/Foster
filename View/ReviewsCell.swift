//
//  ReviewsCell.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-01.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class ReviewsCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var userReview: UILabel!
    @IBOutlet weak var reviewersSchool: UILabel!
    @IBOutlet weak var reviewersName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userReview.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
