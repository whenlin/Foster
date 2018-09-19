//
//  FrontPageVC.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-10.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class FrontPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var currentDayOfWeek: UILabel!
    @IBOutlet weak var dailyEventTable: UITableView!
    @IBOutlet weak var location: UILabel!
    
    var dailyEvents = [DailyEvent]()
    // var mondayEvents = 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillEventArray() //populating daily event table
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        dailyEventTable.dataSource = self
        dailyEventTable.delegate = self
        dailyEventTable.rowHeight = UITableViewAutomaticDimension
        dailyEventTable.estimatedRowHeight = 280
        
        location.text = "London,\nOntario"
        let currentday = Date()
        let formatter = DateFormatter()
        let myCalendar = Calendar(identifier: .gregorian)
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let today = formatter.string(from: currentday)
        
       // todaysDate.text = today
        
        let weekDay = myCalendar.component(.weekday, from: currentday)
        currentDayOfWeek.text = getDayOfWeek(weekday: weekDay)
        
        todaysDate.text = adjustDateLength(Date: today) //currently being checked
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
    
    func fillEventArray(){
        
        for day in days {
            switch(day){
                
            case "Monday":
                var event = DailyEvent(weekDay: day, deals: mondayDeals , dealDescriptions: mondaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            case "Tuesday":
                var event = DailyEvent(weekDay: day, deals: tuesdayDeals , dealDescriptions: tuesdaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            case "Sunday":
                var event = DailyEvent(weekDay: day, deals: sundayDeals , dealDescriptions: sundaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            case "Wednesday":
                var event = DailyEvent(weekDay: day, deals: wednesdayDeals , dealDescriptions: wednesdaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            case "Thursday":
                var event = DailyEvent(weekDay: day, deals: thursdayDeals , dealDescriptions: thursdaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            case "Friday":
                var event = DailyEvent(weekDay: day, deals: fridayDeals , dealDescriptions: fridaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            case "Saturday":
                var event = DailyEvent(weekDay: day, deals: saturdayDeals , dealDescriptions: saturdaydealDescriptions)
                dailyEvents.append(event)
                break;
                
            default:
                break;
            }
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.getDailyEvents().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DailyEventCell") as? DailyEventCell{
            let dailyEvent = self.getDailyEvents()[indexPath.row]
            cell.updateView(event: dailyEvent)
            return cell
        } else {
            return DailyEventCell()
        }
    }
    
    func getDailyEvents() -> [DailyEvent] {
        return dailyEvents
    }
    
    
    
   
}
