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
    
    var reviewerName: String!
    var reviewerSchool: String!
    var review: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(review: BarReview) {
        reviewerName = review.personName
        self.review = review.message
        reviewerSchool = review.institution
        
        theReview.text = self.review + "\n" + reviewerName + " - " + reviewerSchool
    }

}
