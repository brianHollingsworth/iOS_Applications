//
//  ViewController.swift
//  Ultra Countdown
//
//  Created by Brian Hollingsworth on 5/22/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // Ultra 2016 begins March 18th, 2016, 16:00 (Miami)
    let ultraDate = NSDate(timeIntervalSince1970: 1458331200)
    let calendar = NSCalendar.currentCalendar()
    
    let units: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond]
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateLabel"), userInfo: nil, repeats: true)
    }

    func updateLabel() {
        let components = calendar.components(units, fromDate: NSDate(), toDate: ultraDate, options: [])
        
        self.countdownLabel.text = String(format: "%ld:%02ld:%02ld:%02ld.%02ld", components.day, components.hour, components.minute, components.second, (components.nanosecond / 10000000))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

