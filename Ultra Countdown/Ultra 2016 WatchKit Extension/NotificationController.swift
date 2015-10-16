//
//  NotificationController.swift
//  Ultra 2016 WatchKit Extension
//
//  Created by Brian Hollingsworth on 6/23/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

import WatchKit
import Foundation

extension NSDate {
    /**
     * This will add a new method dateAt to NSDate.
     * @brief: It will return a new date at the 
     * specified hour of the receiver.
     *
     * @param: hours   - The hours value
     * @param: minutes - The minutes value
     *
     * @return: A new NSDate with the same year/month/day as the
     *          receiver, but with the specified hour and minutes
     */
    func dateAt(hours hours: Int, minutes: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        // Get today's month/day/year components
        print("Now = \(self)")
        
        let date_components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: self)
        
        // Create an NSDate for 16:00 ETC, when Ultra 2016 will begin.
        date_components.hour   = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.dateFromComponents(date_components)!
        return newDate
    }
}

// Override the == operator when passing two NSDates
public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

let now = NSDate()

let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
let day_component = calendar.components(NSCalendarUnit.Day, fromDate: now)

let ultraStart = now.dateAt(hours: 16, minutes: 0)

let daysUntilUltra = String(format: "%d Days until Ultra!!! 🙌🏼", day_component.day)

class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak var notificationLabel: WKInterfaceLabel!
    
    override init() {
        // Initialize variables here.
        super.init()
        
        if now == ultraStart {
            notificationLabel.setText(daysUntilUltra)
        }
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    /*
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
    
    /*
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
}
