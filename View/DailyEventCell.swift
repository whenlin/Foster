//
//  DailyEventCell.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-30.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class DailyEventCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var barEvent1: UILabel!
    @IBOutlet weak var barEvent2: UILabel!
    @IBOutlet weak var barEvent3: UILabel!
    @IBOutlet weak var barEvent4: UILabel!
    
    var labels: [UILabel] = []
    
    func updateView(event: DailyEvent){
        labels.append(barEvent1)
        labels.append(barEvent2)
        labels.append(barEvent3)
        labels.append(barEvent4)
        weekDay.text = event.weekDay
        var i = 0   //this variable will be used to track the labels array
        for deal in event.deals {
            labels[i].text = deal + " - " + "\n" + event.dealDescriptions[i]
            labels[i].isHidden = false
            i = i + 1
        }
        
    }
    
}
