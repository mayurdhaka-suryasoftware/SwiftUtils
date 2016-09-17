//
//  DateComponents+ISO8601.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 5/9/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//  Ported from https://github.com/soffes/ISO8601

import Foundation

extension DateComponents {

    /**
     Convenience initializer to initialize a DateComponents instance from an ISO-8601 formatted string.

     - parameter iso8601String: String to parse DateComponents from, in ISO-8601 format.

     - returns: A properly initialized DateComponents instance, if passed in String is valid. nil otherwise.
     */
    public init?(iso8601String: String) {
        self.init()

        // We're only ever going to use the Gregorian calendar, so hardcode it.
        self.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)

        let scanner = Scanner(string: iso8601String)
        scanner.charactersToBeSkipped = nil // By default NSScanner will skip whitespace and newline character sets, which we don't want

        // Year
        guard let year = scanner.scanInteger() else {
            return nil
        }
        self.year = year

        // Month
        _ = scanner.scanString("-")
        guard let month = scanner.scanInteger() else {
            return nil
        }
        self.month = month

        // Day
        _ = scanner.scanString("-")
        guard let day = scanner.scanInteger() else {
            return nil
        }
        self.day = day

        // If we were unable to parse up to now, we failed the initializer.
        // However, if this is a date only string (no time), then let it succeed with only date components.
        let foo = scanner.scanCharacters(from: CharacterSet.init(charactersIn: "T "))
        if foo == nil {
            return
        }

        // Hour
        guard let hour = scanner.scanInteger() else {
            return nil
        }
        self.hour = hour

        // Minute
        _ = scanner.scanString(":")
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
        _ = scanner.scanUpToString("Z")
        if let  _ = scanner.scanString("Z") {
            self.timeZone = TimeZone(secondsFromGMT: 0)
            return
        }

        // If it wasn't Zulu, try to parse out time zone
        scanner.scanLocation = scannerLocation
        let signs = CharacterSet(charactersIn: "+-")
        _ = scanner.scanUpToCharacters(from: signs)
        guard let sign = scanner.scanCharacters(from: signs) else {
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

        self.timeZone = TimeZone(secondsFromGMT: timeZoneOffset * timeZoneOffsetMultiplier)
    }

    /// Note that this function will crash if the date property of this DateComponents is nil.
    /// If no timeZone is set, GMT is assumed.
    public var iso8601String: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            if let timeZone = self.timeZone {
                formatter.timeZone = timeZone
            } else {
                formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
            }
            return formatter.string(from: date!)
        }
    }

}
