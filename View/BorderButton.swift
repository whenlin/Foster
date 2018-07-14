//
//  BlackBorderButton.swift
//  BarRank
//
//  Created by WHenlin on 2018-07-14.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

@IBDesignable
class BorderButton: UIButton {

    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: CGColor = UIColor.black.cgColor {
        didSet{
            self.layer.borderColor = borderColor
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
       self.layer.borderWidth = borderWidth
       self.layer.borderColor = borderColor
    }
    
}
