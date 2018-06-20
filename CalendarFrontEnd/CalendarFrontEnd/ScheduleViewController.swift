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

        
        if endTimePicker.date < timePicker.date {
            errorLabel.isHidden = false
        } else {
            
            let parameters = ["event": eventField.text! as AnyObject,
                              "start_time": startTime.titleLabel?.text as AnyObject,
                              "end_time": endTime.titleLabel?.text as AnyObject,
                              "day": datePressed!,
                        ] as [String : AnyObject?]
            
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                let url = NSURL(string: "http://127.0.0.1:5000/api/get_events")!
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = "POST"
                
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                    if error != nil{
                        print("Error -> \(error)")
                        return
                    }
                    do {
                        let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
                        print("Result -> \(result)")
                        
                    } catch {
                        print("Error -> \(error)")
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
