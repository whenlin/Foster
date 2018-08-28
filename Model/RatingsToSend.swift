//
//  RatingsToSend.swift
//  BarRank
//
//  Created by WHenlin on 2018-08-27.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

struct Ratings: Encodable {
    var barName: String!
    var waitTime: String!
    var drinks: String!
    var washrooms: String!
    var music: String!
}

struct RatingsReceived: Decodable {
    var barName: String!
    var waitTime: String!
    var drinks: String!
    var washrooms: String!
    var music: String!
}

struct RatingsFromServer: Decodable {
    var ratings: [RatingsReceived]
}
//struct Review : Decodable {
//    var reviews: [BarReview]
//}
