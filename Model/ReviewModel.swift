//
//  ReviewModel.swift
//  BarRank
//
//  Created by WHenlin on 2018-08-03.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

struct Review{
    var barName: String!
    var personName: String!
    var school: String!
    var review: String!
    
    init(barName: String, personName: String, school: String, review: String) {
        self.barName = barName
        self.personName = personName
        self.school = school
        self.review = review
    }
}
