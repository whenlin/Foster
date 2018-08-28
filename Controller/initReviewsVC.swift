//
//  initReviewsVC.swift
//  BarRank
//
//  Created by WHenlin on 2018-08-22.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class initReviewsVC: UIViewController {

    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var uniProgram: UITextField!
    @IBOutlet weak var schoolView: UIView! //containers for the radio buttons
    @IBOutlet weak var genderView: UIView! //containers for the radio buttons
    var review = BarReview()
    let westernBtn = RadioButton(selectedColor: .blue)   // buttons on the school view
    let fanshaweBtn = RadioButton(selectedColor: .blue)  // buttons on the school view
    let otherBtn = RadioButton(selectedColor: .blue)    //  buttons on the school view
    
    let maleBtn = RadioButton(selectedColor: .blue)     // buttons on the gender view
    let femaleBtn = RadioButton(selectedColor: .blue)   // buttons on the gender view
    let otherGenderBtn = RadioButton(selectedColor: .blue)  // buttons on the gender view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolView.addSubview(westernBtn)
        schoolView.addSubview(fanshaweBtn)
        schoolView.addSubview(otherBtn)
        
        genderView.addSubview(maleBtn)
        genderView.addSubview(femaleBtn)
        genderView.addSubview(otherGenderBtn)
        
        westernBtn.translatesAutoresizingMaskIntoConstraints = false
        fanshaweBtn.translatesAutoresizingMaskIntoConstraints = false
        otherBtn.translatesAutoresizingMaskIntoConstraints = false
        
        maleBtn.translatesAutoresizingMaskIntoConstraints = false
        femaleBtn.translatesAutoresizingMaskIntoConstraints = false
        otherGenderBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            westernBtn.centerYAnchor.constraint(equalTo: schoolView.centerYAnchor),
            westernBtn.leadingAnchor.constraint(equalTo: schoolView.leadingAnchor, constant: 16),
            westernBtn.heightAnchor.constraint(equalToConstant: westernBtn.frame.height),
            westernBtn.widthAnchor.constraint(equalToConstant: westernBtn.frame.width)])
        
        NSLayoutConstraint.activate([
            fanshaweBtn.centerYAnchor.constraint(equalTo: schoolView.centerYAnchor),
            fanshaweBtn.centerXAnchor.constraint(equalTo: schoolView.centerXAnchor),
            fanshaweBtn.heightAnchor.constraint(equalToConstant: fanshaweBtn.frame.height),
            fanshaweBtn.widthAnchor.constraint(equalToConstant: fanshaweBtn.frame.width)])
        
        NSLayoutConstraint.activate([
            otherBtn.centerYAnchor.constraint(equalTo: schoolView.centerYAnchor),
            otherBtn.trailingAnchor.constraint(equalTo: schoolView.trailingAnchor, constant: -16),
            otherBtn.heightAnchor.constraint(equalToConstant: otherBtn.frame.height),
            otherBtn.widthAnchor.constraint(equalToConstant: otherBtn.frame.width)])
        
        NSLayoutConstraint.activate([
            maleBtn.centerYAnchor.constraint(equalTo: genderView.centerYAnchor),
            maleBtn.leadingAnchor.constraint(equalTo: genderView.leadingAnchor, constant: 16),
            maleBtn.heightAnchor.constraint(equalToConstant: westernBtn.frame.height),
            maleBtn.widthAnchor.constraint(equalToConstant: westernBtn.frame.width)])
        
        NSLayoutConstraint.activate([
            femaleBtn.centerYAnchor.constraint(equalTo: genderView.centerYAnchor),
            femaleBtn.centerXAnchor.constraint(equalTo: genderView.centerXAnchor),
            femaleBtn.heightAnchor.constraint(equalToConstant: fanshaweBtn.frame.height),
            femaleBtn.widthAnchor.constraint(equalToConstant: fanshaweBtn.frame.width)])
        
        NSLayoutConstraint.activate([
            otherGenderBtn.centerYAnchor.constraint(equalTo: genderView.centerYAnchor),
            otherGenderBtn.trailingAnchor.constraint(equalTo: genderView.trailingAnchor, constant: -16),
            otherGenderBtn.heightAnchor.constraint(equalToConstant: otherBtn.frame.height),
            otherGenderBtn.widthAnchor.constraint(equalToConstant: otherBtn.frame.width)])
        
        
        
        westernBtn.onSelect {
            
                self.westernBtn.select()
                self.fanshaweBtn.deselect()
                self.otherBtn.deselect()
                self.review.institution = "Western University"
            
        }
        
        westernBtn.onDeselect {
            self.westernBtn.deselect()
        }
        
        fanshaweBtn.onSelect {
           
                self.fanshaweBtn.select()
                self.westernBtn.deselect()
                self.otherBtn.deselect()
                self.review.institution = "Fanshawe College"
            
        }
        
        fanshaweBtn.onDeselect {
            self.fanshaweBtn.deselect()
        }
        
        otherBtn.onSelect {
            
                self.otherBtn.select()
                self.westernBtn.deselect()
                self.fanshaweBtn.deselect()
                self.review.institution = "Other"
            
        }
        
        otherBtn.onDeselect {
            self.otherBtn.deselect()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initVC(nameOfBar: String){
        self.review.barName = nameOfBar
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let createReviewsVC = segue.destination as? createReviewsVC{
                    review.personName = self.personName.text
                    
                    createReviewsVC.passReviewInfo(review: review)
                }
        
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        if(self.personName.text!.count > 0 && self.uniProgram.text!.count > 0){
            performSegue(withIdentifier: "finishReview", sender: review)
        } else {
            
        }
    }
    
}
