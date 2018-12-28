//
//  Bar_Model.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-12.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

struct BarReview : Decodable {
    
    var barName: String!
    var personName: String!
    var institution: String!
    var _id: String!
    var message: String!
    
    enum CodingKeys: String, CodingKey {
        case _id
        case barName
        case personName
        case message
        case institution = "school"
    }
}
