//
//  BarMenuVC.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-10.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import UIKit

class BarMenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    //Outlets
    
    @IBOutlet weak var listOfBars: UITableView!
    
    
    //properties
    var tableData: [Bar] = [Bar]() //array that holds the bars
    var barNames: [String] = [String]() //array holding the bar names
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        listOfBars.dataSource = self
        listOfBars.delegate = self
        self.tableData = getBarData(url: URL_GETBARS)  //retrieve data from api
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getBars().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BarsCell") as? BarsCell{
            let bar = self.getBars()[indexPath.row]
            cell.updateViews(bar: bar)
            return cell
        } else {
            return BarsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bar = self.getBars()[indexPath.row]
        performSegue(withIdentifier: "ReviewsVC", sender: bar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let reviewsVC = segue.destination as? ReviewsVC{
              assert(sender as? Bar != nil)
              reviewsVC.initBars(bar: sender as! Bar)
        }
        
          let barBtn = UIBarButtonItem()
          barBtn.title = ""
          navigationItem.backBarButtonItem = barBtn
    }
    
    func getBarData(url: String) -> [Bar] {  //gets data from api then returns array
        //Implement code here
        
        tableData = retrieveBars(){
            (success) in
            if success {
                print("Worked!")
            }
        }
        
        return tableData
    }
    
    func getBars() -> [Bar] {        //returns array
        return tableData
    }
    
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
                self.tableData.append(Bar(title: index, imageName: imageName))
            }
            
            print(self.barNames)
            
            DispatchQueue.main.async {
                self.listOfBars.reloadData()
            }
            
        }
        
        task.resume()
        
        
        return tableData
    }
    
    
    
    
}
