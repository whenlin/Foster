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
    
    var dailyEvents = [DailyEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        dailyEventTable.dataSource = self
        dailyEventTable.delegate = self
        let currentday = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        todaysDate.text = formatter.string(from: currentday)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.getDailyEvents().count
    }
    
    
    //MODIFY THIS FUNCTION AS IT HAS NOT BEEN APPROPRIATED TO THIS VIEW CONTROLLER CLASS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BarsCell") as? BarsCell{
            let bar = self.getDailyEvents()[indexPath.row]
          //  cell.updateViews(bar: bar)
            return cell
        } else {
            return BarsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let bar = self.getBars()[indexPath.row]
//        //   performSegue(withIdentifier: "ReviewsVC", sender: bar)
//        performSegue(withIdentifier: "BarRatingVC", sender: bar)
    }
    
    func getDailyEvents() -> [DailyEvent] {
        return dailyEvents
    }
    
    
    
   
}
