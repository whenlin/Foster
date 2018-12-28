//
//  BarInfo_Model.swift
//  BarRank
//
//  Created by WHenlin on 2018-12-28.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

struct BarInfo : Decodable {
    
    var _id: String!
    var barName: String!
    var province: String!
    var city: String!
    var address: String!
    
    enum CodingKeys: String, CodingKey {
        case _id
        case barName
        case province
        case city
        case address
    }
}
