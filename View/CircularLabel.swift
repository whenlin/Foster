//
//  CircularLabel.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-13.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class CircularLabel: UILabel {
    
    @IBInspectable var BorderWidth: CGFloat = 4.0 {
        didSet{
            self.layer.borderWidth = 3.0
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView(){
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.width/2
    }
    

}
