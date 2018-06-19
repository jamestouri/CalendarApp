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
    
    @IBOutlet var conflictLabel: UILabel!
    
    @IBOutlet var eventField: UITextField!
    
    @IBOutlet var startTime: UIButton!
    @IBOutlet var endTime: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conflictLabel.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func beginningOfEvent(_ sender: Any) {
    }
    
    @IBAction func endOfEvent(_ sender: Any) {
        
        
    }
    
    
    
    @IBAction func saveEvent(_ sender: Any) {
        
        let parameters: [String : AnyObject?]
        
        var conflict: Bool = false
        
        if conflictLabel.text != "" {
            conflict = true
        }
        
        parameters = ["event": eventField.text as AnyObject,
                      "start_time": startTime.titleLabel?.text,
                      "end_time": endTime.titleLabel?.text,
                      "day": datePressed,
                      "conflict": conflict
                    ] as [String : AnyObject?]
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
