//
//  NSDateComponents+ISO8601.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 5/9/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//  Ported from https://github.com/soffes/ISO8601

import Foundation

extension NSDateComponents {

    /**
     Convenience initializer to initialize an NSDateComponents instance from an ISO-8601 formatted string.

     - parameter iso8601String: String to parse NSDateComponents from, in ISO-8601 format.

     - returns: A properly initialized NSDateComponents instance, if passed in String is valid. nil otherwise.
     */
    public convenience init?(iso8601String: String) {
        self.init()

        // We're only ever going to use the Gregorian calendar, so hardcode it.
        self.calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)

        let scanner = NSScanner(string: iso8601String)
        scanner.charactersToBeSkipped = nil // By default NSScanner will skip whitespace and newline character sets, which we don't want

        // Year
        guard let year = scanner.scanInteger() else {
            return nil
        }
        self.year = year

        // Month
        scanner.scanString("-")
        guard let month = scanner.scanInteger() else {
            return nil
        }
        self.month = month

        // Day
        scanner.scanString("-")
        guard let day = scanner.scanInteger() else {
            return nil
        }
        self.day = day

        // If we were unable to parse up to now, we failed the initializer.
        // However, if this is a date only string (no time), then let it succeed with only date components.
        let foo = scanner.scanCharactersFromSet(NSCharacterSet.init(charactersInString: "T "))
        if foo == nil {
            return
        }

        // Hour
        guard let hour = scanner.scanInteger() else {
            return nil
        }
        self.hour = hour

        // Minute
        scanner.scanString(":")
        guard let minute = scanner.scanInteger() else {
            return nil
        }
        self.minute = minute

        // Second
        // If second does exist, read and set it. Otherwise go back to where the scanner was.
        // Do not fail if second does not exist.
        var scannerLocation = scanner.scanLocation
        if let _ = scanner.scanString(":") {
            guard let second = scanner.scanInteger() else {
                return nil
            }
            self.second = second
        } else {
            scanner.scanLocation = scannerLocation
        }

        // Timezone

        // Z stands for the Zulu timezone, which is the same as UTC.
        // If Z exists, then we know it is UTC, so set the time zone and return.
        scannerLocation = scanner.scanLocation
        scanner.scanUpToString("Z")
        if let  _ = scanner.scanString("Z") {
            self.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            return
        }

        // If it wasn't Zulu, try to parse out time zone
        scanner.scanLocation = scannerLocation
        let signs = NSCharacterSet(charactersInString: "+-")
        scanner.scanUpToCharactersFromSet(signs)
        guard let sign = scanner.scanCharactersFromSet(signs) else {
            return
        }
        let timeZoneOffsetMultiplier: Int
        switch sign {
        case "+":
            timeZoneOffsetMultiplier = 1
        case "-":
            timeZoneOffsetMultiplier = -1
        default:
            fatalError()
        }

        let timeZoneOffsetMinute: Int

        guard var timeZoneOffsetHour = scanner.scanInteger() else {
            return nil
        }
        let colonExists = scanner.scanString(":") != nil
        if !colonExists && timeZoneOffsetHour > 14 {
            // If there is no colon, it must be one of HHMM or HH
            // HH can only go up to 14, see https://en.wikipedia.org/wiki/List_of_UTC_time_offsets
            // This handles the HHMM case, the HH case was already handled
            timeZoneOffsetMinute = timeZoneOffsetHour % 100
            timeZoneOffsetHour = Int(floor(Double(timeZoneOffsetHour) / Double(100)))
        } else {
            if let _timeZoneOffsetMinute = scanner.scanInteger() {
                timeZoneOffsetMinute = _timeZoneOffsetMinute
            } else {
                timeZoneOffsetMinute = 0
            }
        }

        let timeZoneOffset = (timeZoneOffsetHour * 60 * 60) + (timeZoneOffsetMinute * 60)

        self.timeZone = NSTimeZone(forSecondsFromGMT: timeZoneOffset * timeZoneOffsetMultiplier)
    }

}
