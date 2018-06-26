//
//  ScheduleViewController.swift
//  CalendarFrontEnd
//
//  Created by James touri on 6/18/18.
//  Copyright © 2018 jamestouri. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet var dayLabel: UILabel!
    

    @IBOutlet var eventField: UITextField!
    
    @IBOutlet var startTime: UIButton!
    @IBOutlet var endTime: UIButton!
    
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var endTimePicker: UIDatePicker!
    
    @IBOutlet var errorLabel: UILabel!
    
    
    
    let dayOfWeek = [1: "Sunday",
                     2: "Monday",
                     3: "Tuesday",
                     4: "Wednesday",
                     5: "Thursday",
                     6: "Friday",
                     7: "Saturday"
                    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        self.eventField.becomeFirstResponder()
        
        let selectedDay: Int? = Int(datePressed!)! % 7
        
        dayLabel.text = dayOfWeek[selectedDay!]! + " " + datePressed!
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        timePicker.isHidden = true
        endTimePicker.isHidden = true
        

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func beginningOfEvent(_ sender: Any) {
        
        endTimePicker.isHidden = true
        timePicker.isHidden = false
        
        let givenTime = DateFormatter()
        givenTime.dateFormat = "h:mm a"
        givenTime.amSymbol = "am"
        givenTime.pmSymbol = "pm"

        startTime.setTitle(givenTime.string(from: timePicker.date), for: .normal)
    }
    
    
    @IBAction func endOfEvent(_ sender: Any) {
        //get value of choosing
        timePicker.isHidden = true
        endTimePicker.isHidden = false
        
        let givenTime = DateFormatter()
        givenTime.dateFormat = "h:mm a"
        givenTime.amSymbol = "am"
        givenTime.pmSymbol = "pm"
        
        startTime.setTitle(givenTime.string(from: timePicker.date), for: .normal)
        
        endTime.setTitle(givenTime.string(from: endTimePicker.date), for: .normal)

    }
    
    
    
    @IBAction func saveEvent(_ sender: Any) {
        
        let givenTime = DateFormatter()
        givenTime.dateFormat = "h:mm a"
        givenTime.amSymbol = "am"
        givenTime.pmSymbol = "pm"
        endTime.setTitle(givenTime.string(from: endTimePicker.date), for: .normal)

        // Making sure times chosen is possible
        if endTimePicker.date < timePicker.date {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            
            let parameters = ["event": eventField.text! as String,
                              "start_time": startTime.titleLabel?.text as! String,
                              "end_time": endTime.titleLabel?.text as! String,
                              "day": datePressed as! String,
                              ]
            do {
                // POST Method to store in database
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                let url = NSURL(string: "http://127.0.0.1:5000/events")!
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = "POST"
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                    if error != nil{
                        print("Error -> \(String(describing: error))")
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: (data!), options: .allowFragments) as? [String:AnyObject]
                        print("Result -> \(String(describing: json!))")
                        
                    } catch {
                        print("Error at catch -> \(error)")
                    }
                }
                
                task.resume()
            } catch {
                print(error)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    

}
