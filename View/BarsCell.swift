//
//  BarsCell.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-12.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class BarsCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barImage: UIImageView!
    
    
    func updateViews(bar: Bar){
        barImage.image =  UIImage(named: bar.imageName)
        barName.text =  bar.title
    }
}
