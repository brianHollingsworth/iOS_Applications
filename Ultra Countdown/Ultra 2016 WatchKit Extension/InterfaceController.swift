//
//  InterfaceController.swift
//  Ultra 2016 WatchKit Extension
//
//  Created by Brian Hollingsworth on 6/23/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    // Ultra 2016 begins March 18th, 2016, 16:00 (Miami)
    let ultraDate = NSDate(timeIntervalSince1970: 1458331200)
    let calendar = NSCalendar.currentCalendar()
    
    let units: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond]
    
    let miamiSquad = UIImage(named: "Miami_Squad.png")
    
    @IBOutlet weak var squadImage: WKInterfaceImage!
    @IBOutlet weak var countdownLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        squadImage.setImage(miamiSquad)
    }
    
    func updateWatchLabel() {
        let components = calendar.components(units, fromDate: NSDate(), toDate: ultraDate, options: [])
        
        countdownLabel.setText("\(components.day) Days, \(components.hour):\(components.minute):\(components.second)")

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        var watchTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateWatchLabel"), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
