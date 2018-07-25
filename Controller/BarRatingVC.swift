//
//  BarRatingVC.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-03.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit
//import UberRides
//CONFIGURE THIS PROJECT WITH UBER CREDENTIALS ETC FROM GITHUB SDK BEFORE YOU UNCOMMENT THIS!!!

class BarRatingVC: UIViewController {

    //Outlets
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barRating: UILabel!
    @IBOutlet weak var uberView: UIView!
    @IBOutlet weak var barImage: UIImageView!
    
    
    var barAddress: String!
    var nameOfBar: String!
    var imageURL: String!
    
    
  //  let uberBtn = RideRequestButton()
//UNCOMMENT THIS WHEN YOU CONFIGURED THIS PROJECT WITH NECESSARY UBER DETAILS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barName.text = nameOfBar
        barImage.image = UIImage(named: imageURL)
        setupUberBtnConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initRatings(bar: Bar){
        
        nameOfBar = bar.title
        imageURL = bar.imageName
      //  self.barRating.text =
        //gonna have to call the api to get the respective bar's ratings
        //probs should implement a function that gets the ratings then place that function in viewDidLoad()
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {  //navigates users back to the list of bars
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reviewsBtnClicked(_ sender: Any) { //navigates user to the page where they can rate the spot
        
    }
    
    func setupUberBtnConstraints(){         //function name is self-explanatory
        
    }
    
}
