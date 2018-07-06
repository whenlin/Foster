//
//  ReviewsVC.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-17.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class ReviewsVC: UIViewController {

    //Outlets
    @IBOutlet weak var listOfReviews: UITableView!
    @IBOutlet weak var nameOfBar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initBars(bar: Bar){
        nameOfBar.text = bar.title
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
