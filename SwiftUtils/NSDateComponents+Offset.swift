//
//  NSDateComponents+Offset.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import Foundation

extension NSDateComponents {

    /**
     Instantiates an NSDateComponents instance that is the point in time pointed to by date,
     but in the timezone pointed to by offset.

     So for instance, 2016-08-24T05:30:00+0530 at offset Z would be 2016-08-24T000:00:00Z

     - parameter date:   point in time to convert to NSDateComponents
     - parameter offset: timezone offset of timezone in which returned NSDateComponents should be in

     - returns: NSDateComponent that is the point in time pointed to by date, in the timezone pointed to by offset.
     */
    public class func fromDate(date: NSDate, inTimezoneOffset offset: String) -> NSDateComponents? {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)!
        guard let timeZone = NSTimeZone.fromOffset(offset) else {
            return nil
        }
        calendar.timeZone = timeZone
        return calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second, .TimeZone], fromDate: date)
    }

}
