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
    @IBOutlet weak var theReview: UILabel!
    @IBOutlet weak var nameOfReviewer: UILabel!
    @IBOutlet weak var schoolOfReviewer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(review: BarReview) {
        nameOfReviewer.text = review.personName
        theReview.text = review.message
        schoolOfReviewer.text = review.institution
    }

}
