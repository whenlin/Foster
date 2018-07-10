//
//  BarRatingVC.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-03.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class BarRatingVC: UIViewController {

    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initRatings(bar: Bar){
        
        self.barName.text = bar.title
      //  self.barRating.text = barRating
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reviewsBtnClicked(_ sender: Any) {
    }
    
}
