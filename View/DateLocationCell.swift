//
//  DateLocationCell.swift
//  BarRank
//
//  Created by WHenlin on 2018-09-21.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class DateLocationCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var currentDayOfWeek: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView(){
        self.location.text = "London,\nOntario"
        let currentday = Date()
        let formatter = DateFormatter()
        let myCalendar = Calendar(identifier: .gregorian)
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let today = formatter.string(from: currentday)
        
        // todaysDate.text = today
        
        let weekDay = myCalendar.component(.weekday, from: currentday)
        self.currentDayOfWeek.text = getDayOfWeek(weekday: weekDay)
        
        self.todaysDate.text = adjustDateLength(Date: today) //currently being checked
    }
    
    func adjustDateLength(Date: String) -> String{
        
        var array: [Substring]
        array = Date.split(separator: " ")
        var resultString: String
        resultString = ""
        
        var month: String
        
        switch(array[0]){
        case "February":
            month = "Feb"
            break;
            
        case "January":
            month = "Jan"
            break;
            
        case "August":
            month = "Aug"
            break;
            
        case "September":
            month = "Sept"
            break;
            
        case "October":
            month = "Oct"
            break;
            
        case "November":
            month = "Nov"
            break;
            
        case "December":
            month = "Dec"
            break;
            
        default:
            month = "Jan"
            break;
            
        }
        
        var i = 0
        while(i < array.count){
            if(i == 0){
                resultString += month + " "
            }
            else{
                resultString += array[i] + " "
            }
            i = i + 1
        }
        
        return resultString
    }
    
    func getDayOfWeek(weekday: Int) -> String {
        var result: String
        
        switch(weekday){
        case 1:
            result = "Sunday"
            break;
        case 2:
            result = "Monday"
            break;
        case 3:
            result = "Tuesday"
            break;
        case 4:
            result = "Wednesday"
            break;
        case 5:
            result = "Thursday"
            break;
        case 6:
            result = "Friday"
            break;
        case 7:
            result = "Saturday"
            break;
            
        default:
            result = "Sunday"
            break;
        }
        return result
    }
    
    

}
