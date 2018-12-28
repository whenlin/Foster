//
//  BarRatingVC.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-03.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit
import CoreLocation
import Cosmos
import UberRides

class BarRatingVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    //Outlets
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barRating: UILabel!
    @IBOutlet weak var uberView: UIView!
    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var listOfReviews: UITableView!
    @IBOutlet weak var showAllReviewsBtn: UIButton!
    @IBOutlet weak var loadingCommentsIndicator: UIActivityIndicatorView!
    @IBOutlet weak var drinksRating: CosmosView!
    @IBOutlet weak var linesRating: CosmosView!
    @IBOutlet weak var washroomsRating: CosmosView!
    @IBOutlet weak var musicRating: CosmosView!
    @IBOutlet weak var overallBarRating: CircularLabel!    //this is the average of the above ratings
    
    //Important variables for the VC
    var barAddress: String!
    var nameOfBar: String!
    var imageURL: String!
    var reviews: [BarReview] = [BarReview]()
    var ratings: [RatingsReceived] = [RatingsReceived]()
    
  //  let uberBtn = RideRequestButton()
//UNCOMMENT THIS WHEN YOU CONFIGURED THIS PROJECT WITH NECESSARY UBER DETAILS
    
    @IBAction func unwindToBarRatingVC(segue:UIStoryboardSegue) {
        self.listOfReviews.reloadData()
    }
    
    let locationManager = CLLocationManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barName.text = nameOfBar
        barImage.image = UIImage(named: imageURL)
        listOfReviews.dataSource = self
        listOfReviews.delegate = self
        listOfReviews.rowHeight = UITableViewAutomaticDimension
        listOfReviews.estimatedRowHeight = 70
        
        //setting up star ratings below
        drinksRating.settings.fillMode = .precise
        washroomsRating.settings.fillMode = .precise
        musicRating.settings.fillMode = .precise
        linesRating.settings.fillMode = .precise
        
        self.fetchInitialReviews() {
            (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                print("Success!!!")
            }
        }
        
        self.fetchBarRatings(){
            (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                print("Ratings worked!!!")
            }
        }
        
        let uberBtn = RideRequestButton()
        uberView.translatesAutoresizingMaskIntoConstraints = false
        uberBtn.center = CGPoint(x: overallBarRating.center.x , y: overallBarRating.center.y + 60)
//        let leftEdge = NSLayoutConstraint(item: uberBtn, attribute: .left, relatedBy: .equal, toItem: uberView, attribute: .left, multiplier: 1.0, constant: 0.0)
//        let rightEdge = NSLayoutConstraint(item: uberBtn, attribute: .right, relatedBy: .equal, toItem: uberView, attribute: .right, multiplier: 1.0, constant: 0.0)
//        uberBtn.addConstraint(leftEdge)
//        uberBtn.addConstraint(rightEdge)
        uberView.addSubview(uberBtn)
        
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
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {  //navigates users back to the list of bars
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reviewsBtnClicked(_ sender: Any) { //navigates user to the page where they can rate the spot
        let bar = Bar(title: nameOfBar, imageName: imageURL)
        performSegue(withIdentifier: "makeReview", sender: bar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let initReviewsVC = segue.destination as? initReviewsVC{
                      
                    initReviewsVC.initVC(nameOfBar: self.nameOfBar)
                }

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
    
    func fetchBarRatings(completion:((Error?) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "54.190.19.155"
        urlComponents.port = 3000
        urlComponents.path = "/ratings/" + nameOfBar
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a GET method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
            
            guard let barRatings = try? JSONDecoder().decode(RatingsFromServer.self, from: responseData!) else {
                print("Error: Couldn't decode data into Ratings array")
                return
            }
        
            let rating_json_array = barRatings.ratings
            
            if rating_json_array.count > 0 {
                for eachRating in rating_json_array {
                    var rating: RatingsReceived! = RatingsReceived()
                    rating.overallAvg = eachRating.overallAvg
                    rating.waitTime = eachRating.waitTime
                    rating.drinks = eachRating.drinks
                    rating.washrooms = eachRating.washrooms
                    rating.music = eachRating.music
                    self.ratings.append(rating)
                }
            }
            
            DispatchQueue.main.async {
                let drinks = Double(self.ratings[0].drinks)
                let washrooms = Double(self.ratings[0].washrooms)
                let music = Double(self.ratings[0].music)
                let lines = Double(self.ratings[0].waitTime)
                
                //updating UI
                self.drinksRating.rating =  drinks!
                self.washroomsRating.rating = washrooms!
                self.musicRating.rating = music!
                self.linesRating.rating = lines!
                self.overallBarRating.text = self.ratings[0].overallAvg
            }
        }
        task.resume()
    }

    
    func fetchInitialReviews(completion:((Error?) -> Void)?) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "54.190.19.155"
        urlComponents.port = 3000
        urlComponents.path = "/reviews/" + nameOfBar
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers

        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your GET request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
            
            guard let barReview = try? JSONDecoder().decode(Review.self, from: responseData!) else {
                print("Error: Couldn't decode data into Reviews")
                return
            }
            
            let review_json_array = barReview.reviews
            
            if review_json_array.count > 0 {
                
           //     print(review_json_array[0])
                
                for eachReview in review_json_array {
                    var review: BarReview! = BarReview()
                    review._id = eachReview._id
                    review.barName = eachReview.barName
                    review.institution = eachReview.institution
                    review.message = eachReview.message
                    review.personName = eachReview.personName
                    self.reviews.append(review)
                }
            }
            
            DispatchQueue.main.async {
                self.listOfReviews.reloadData()
            }
            
        }
        task.resume()
        
    }

    func getAllReviews(completion:((Error?) -> Void)?) -> [BarReview] { //MODIFY THIS FUNCTION LIKE THE ONE ABOVE
        
        var urlComponents = URLComponents()
       // urlComponents.scheme = "https"
        urlComponents.scheme = "http"
       // urlComponents.host = "bar-app-whenlin.c9users.io"
        urlComponents.host = "54.190.19.155"
        urlComponents.port = 3000
        urlComponents.path = "/allReviews/" + nameOfBar
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
            
            guard let barReview = try? JSONDecoder().decode(Review.self, from: responseData!) else {
                print("Error: Couldn't decode data into Reviews")
                return
            }
            
            let review_json_array = barReview.reviews
            
            if review_json_array.count > 0 {
                for eachReview in review_json_array {
                    var review: BarReview! = BarReview()
                    review._id = eachReview._id
                    review.barName = eachReview.barName
                    review.institution = eachReview.institution
                    review.message = eachReview.message
                    review.personName = eachReview.personName
                    self.reviews.append(review)
                }
            }
            
            DispatchQueue.main.async {
                self.listOfReviews.reloadData()
            }
            
        }
        task.resume()
        return reviews
    }
    
    @IBAction func getAllReviews(_ sender: Any) {
        loadingCommentsIndicator.startAnimating()
        reviews.removeAll()
        reviews = self.getAllReviews(){
            (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                print("Success!!!!!")
            }
        }
        loadingCommentsIndicator.stopAnimating()
    }
    
}

