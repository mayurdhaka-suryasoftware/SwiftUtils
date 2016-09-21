//
//  DateComponents+Offset.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import Foundation

extension DateComponents {

    /**
     Instantiates a DateComponents instance that is the point in time pointed to by date,
     but in the timezone pointed to by offset.

     So for instance, 2016-08-24T05:30:00+0530 at offset Z would be 2016-08-24T000:00:00Z

     - parameter date:   point in time to convert to NSDateComponents
     - parameter offset: timezone offset of timezone in which returned NSDateComponents should be in

     - returns: DateComponent that is the point in time pointed to by date, in the timezone pointed to by offset.
     */
    public static func from(date: Date, inTimezoneOffset offset: String) -> DateComponents? {
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        guard let timeZone = TimeZone.from(offset: offset) else {
            return nil
        }
        calendar.timeZone = timeZone
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: date)
        components.calendar = calendar
        return components
    }

}
