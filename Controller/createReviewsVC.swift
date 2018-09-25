//
//  createReviews.swift
//  BarRank
//
//  Created by WHenlin on 2018-08-19.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit
import Cosmos

class createReviewsVC: UIViewController,UITextViewDelegate {

    var review = BarReview()
    
    //Outlets
    @IBOutlet weak var drinksRating: CosmosView!
    @IBOutlet weak var musicRating: CosmosView!
    @IBOutlet weak var waitRating: CosmosView!
    @IBOutlet weak var washroomRating: CosmosView!
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var barName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //hides keyboard
        submitBtn.isEnabled = false
        submitBtn.isHidden = true
        // Do any additional setup after loading the view.
        //print(review)
        self.barName.text = self.review.barName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func passReviewInfo(review: BarReview){
        self.review = review
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.comments {          //enables the submit btn if comment box has text, disables otherwise
            self.submitBtn.isEnabled = !comments.text.isEmpty
            self.submitBtn.isHidden = comments.text.isEmpty
        }
    }

    func submitBtnClicked() {
        
        review.message = comments.text
        
        var reviewToSend = reviewMessage()
        reviewToSend._id = ""
        reviewToSend.barName = review.barName
        reviewToSend.institution = review.institution
        reviewToSend.message = review.message
        reviewToSend.personName = review.personName
        
        var ratingsToSend = Ratings()
        ratingsToSend.barName = review.barName
        ratingsToSend.drinks = String(format:"%f",self.drinksRating.rating)
        ratingsToSend.music = String(format:"%f",self.musicRating.rating)
        ratingsToSend.waitTime = String(format:"%f",self.waitRating.rating)
        ratingsToSend.washrooms = String(format:"%f",self.washroomRating.rating)
        
        sendReviewToServer(theReview: reviewToSend){
            (success) in
            if (success != nil) {
                print(success as Any)
            } else {
                print("Failed!")
            }
        }
        
        sendRatingToServer(theRatings: ratingsToSend) {
            (success) in
            if (success != nil) {
                print(success as Any)
            } else {
                print("Failed!")
            }
        }
    }
    
    func sendRatingToServer(theRatings: Ratings, completion:((Error?) -> Void)?){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "bar-app-whenlin.c9users.io"
        urlComponents.path = "/ratings"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(theRatings)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
    
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
        }
        task.resume()
    }
    
    func sendReviewToServer(theReview: reviewMessage, completion:((Error?) -> Void)?){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "bar-app-whenlin.c9users.io"
        urlComponents.path = "/addReview"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(theReview)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
        }
        task.resume()
    }
    
    @IBAction func unwindToBarRatingVC(segue: UIStoryboardSegue) {
        print("Unwinding to Bar Profile")
        submitBtnClicked()
        performSegue(withIdentifier: "unwindToBarRating", sender: self)
    }

    
}
