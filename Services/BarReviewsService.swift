//
//  BarReviewsService.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-03.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

class BarReviewsService {
 
    static let instance = BarReviewsService()
    let defaults = UserDefaults.standard
    
    var ratings = [Float]() //this array will hold the values of each respective rating
    var reviews = [String]() //this array will hold the reviews received from the request
    
    //must implement function that will make a request to the api
    
    
    func calculateAvgRating(array: [Float]) -> Float {
        var avg: Float
        var sum: Float
        avg = 0
        sum = 0
        
        if(array.count > 0){
            for rating in array{
                sum = sum + rating
            }
            let float = Float(array.count) //converts from int to float
            avg = sum / float // calculate avg rating
        }
        return avg
    }
    
}
