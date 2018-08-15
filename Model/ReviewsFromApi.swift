//
//  ReviewsFromApi.swift
//  BarRank
//
//  Created by WHenlin on 2018-08-14.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

struct Review : Decodable {
    var reviews: [BarReview]
}
