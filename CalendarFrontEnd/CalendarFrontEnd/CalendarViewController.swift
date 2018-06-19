//
//  CalendarViewController.swift
//  CalendarFrontEnd
//
//  Created by James touri on 6/18/18.
//  Copyright © 2018 jamestouri. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet var dates: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segueAndButtonCreate(_ sender: Any) {
        
        datePressed = (sender as AnyObject).title(for: .normal)
        
        self.performSegue(withIdentifier: "schedule", sender: self)
        
        
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
