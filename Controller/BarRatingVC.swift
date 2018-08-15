//
//  BarRatingVC.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-03.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit
import CoreLocation
//import UberRides
//CONFIGURE THIS PROJECT WITH UBER CREDENTIALS ETC FROM GITHUB SDK BEFORE YOU UNCOMMENT THIS!!!

class BarRatingVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    

    //Outlets
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barRating: UILabel!
    @IBOutlet weak var uberView: UIView!
    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var listOfReviews: UITableView!
    @IBOutlet weak var showAllReviewsBtn: UIButton!
    
    var barAddress: String!
    var nameOfBar: String!
    var imageURL: String!
    var reviews: [BarReview] = [BarReview]()
    
  //  let uberBtn = RideRequestButton()
//UNCOMMENT THIS WHEN YOU CONFIGURED THIS PROJECT WITH NECESSARY UBER DETAILS
    
    let locationManager = CLLocationManager()
    
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print(location.coordinate)
//        }
    }
    
    // If we have been denied access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been denied access
    func showLocationDisabledPopUp() {
//        let alertController = UIAlertController(title: "Background Location Access Disabled",
//                                                message: "In order to deliver pizza we need your location",
//                                                preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//            if let url = URL(string: UIApplicationOpenSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//        alertController.addAction(openAction)
//
//        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barName.text = nameOfBar
        barImage.image = UIImage(named: imageURL)
        listOfReviews.dataSource = self
        listOfReviews.delegate = self
        
        reviews = self.getInitialReviews(){
            (success) in
            if success {
                print("Worked!")
            } else {
                print("Failed!")
            }
        }
        
        
        
     //   setupUberBtnConstraints()
        
        //  UNCOMMENT THE BLOCK BELOW WHEN YOU ARE READYYY - WILLIAM!!!!!!!!!!!!!!!!!!!!!!!!!
        
//        // For use when the app is open & in the background
//        locationManager.requestAlwaysAuthorization()
//
//        // For use when the app is open
//        //locationManager.requestWhenInUseAuthorization()
//
//        // If location services is enabled get the users location
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
//            locationManager.startUpdatingLocation()
//        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell") as? ReviewsCell{
            let review = self.getReviews()[indexPath.row]
            cell.updateViews(review: review)
            return cell
        } else {
            return ReviewsCell()
        }
    }
    
    func getReviews() -> [BarReview]{
        return reviews
    }
    
    func getInitialReviews(completion: @escaping CompletionHandler) -> [BarReview] {
        //get limited number of reviews from api
        let jsonURL = URL_GETREVIEWS + nameOfBar
        let url = URL(string: jsonURL)

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in

            guard error == nil else {
                print("returned error")
                return
            }

            guard let content = data else {
                print("No data")
                return
            }

//            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
//                print("Not containing JSON")
//                return
//            }
            
            guard let barReview = try? JSONDecoder().decode(Review.self, from: content) else {
                print("Error: Couldn't decode data into Reviews")
                return
            }
            
            let review_json_array = barReview.reviews
            
            print(review_json_array[0])
            
            for eachReview in review_json_array {
                var review: BarReview! = BarReview()
                review._id = eachReview._id
                review.barName = eachReview.barName
                review.institution = eachReview.institution
                review.message = eachReview.message
                review.personName = eachReview.personName
                self.reviews.append(review)
            }
            
//            for index in self.barNames {
//                let imageName = index + ".jpg"
//                self.tableData.append(Bar(title: index, imageName: imageName))
//            }
//
//            print(self.barNames)
//
            DispatchQueue.main.async {
                self.listOfReviews.reloadData()
            }

        }

        task.resume()
        
        
        return reviews
    }
    
    func getAllReviews() {
        //get all reviews for specified bar from api
    }
    
    func setupUberBtnConstraints(){         //function name is self-explanatory
        uberView.translatesAutoresizingMaskIntoConstraints = false
        
      //  let blah - NSLayoutConstraint(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
        
        let topConstraint = NSLayoutConstraint(item: uberView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: uberView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leftConstraint = NSLayoutConstraint(item: uberView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let rightConstraint = NSLayoutConstraint(item: uberView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0)
        
        view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
}
