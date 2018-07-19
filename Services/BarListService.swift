//
//  BarListService.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-17.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON

class BarListService {
    
    static let instance = BarListService()
    
    private var bars = [Bar]()
    private var barNames = [String]()
    
    let defaults = UserDefaults.standard
    
    func retrieveBars(completion: @escaping CompletionHandler) -> [Bar] {
        
        let jsonURL = URL_GETBARS
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
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            if let array = json["bars"] as? [String] {
                self.barNames = array
            }
            
            for index in self.barNames {
                let imageName = index + ".jpg"
                self.bars.append(Bar(title: index, imageName: imageName))
            }
            
            print(self.barNames)
            
        }
        
        
        
        task.resume()
        
        
        return bars
    }
    
    
    
    func getBars() -> [Bar]{
        
        if bars.count == 0{
           return retrieveBars(){
                (success) in
                if success {
                    print("SUCCESS!!!")
                } else {
                    print("FAILED!!!")
                }
            }
        }
        
        return bars
    }
}
