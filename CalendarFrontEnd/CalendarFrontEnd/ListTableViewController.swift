//
//  ListTableViewController.swift
//  CalendarFrontEnd
//
//  Created by James touri on 6/18/18.
//  Copyright © 2018 jamestouri. All rights reserved.
//

import UIKit

class ListTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var eventResult: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // store only the events on the particular day
        getEvents() { (completionHandler: NSArray) in
            
            var tempArray: NSArray
            tempArray = completionHandler
            var selectedDays = [NSDictionary]()
            for i in 0..<tempArray.count {
                
                let tempDict: NSDictionary = tempArray[i] as! NSDictionary
                // If the day matches the day that was pressed 
                if tempDict.object(forKey: "day") as? String == datePressed {
                    selectedDays.append(tempDict)
                }
            }
            DispatchQueue.main.async {
                self.eventResult = selectedDays as NSArray
                self.tableView.reloadData()
            }
            
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Using GET method to get from Flask
func getEvents(completionHandler: @escaping (NSArray) -> Void) {
    let url = URL(string: "http://127.0.0.1:5000/events")!
    
    let dataTask = URLSession.shared.dataTask(with: url) {
        data,response,error in

        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                
                completionHandler(jsonResult as! NSArray)
                //Use GCD to invoke the completion handler on the main thread
              
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    dataTask.resume()
}


extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventResult.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = eventResult[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let startingTime = (event as! NSDictionary).object(forKey: "start_time") as! String
        let endingTime = (event as! NSDictionary).object(forKey: "end_time") as! String
        
        
        cell.detailTextLabel?.text = startingTime + " to " + endingTime
        cell.textLabel?.text = (event as AnyObject).object(forKey: "event") as? String
        return cell
    }
    
    
    
    
}
