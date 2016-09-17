//
//  TimeZone+Offset.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//  Ported from https://github.com/soffes/ISO8601

import Foundation

extension TimeZone {

    /**
     Instantiates an TimeZone from an offset value. The offset value must be an ISO8601 compliant string.

     For instance, and offset of Z would refer to Zulu time zone, or UTC.

     +0530 would be Indian Standard Time.

     - parameter offset: ISO8601 compliant offset string

     - returns: TimeZone from offset string
     */
    public static func from(offset: String) -> TimeZone? {
        let scanner = Scanner.init(string: offset)
        // Z stands for the Zulu timezone, which is the same as UTC.
        // If Z exists, then we know it is UTC, so set the time zone and return.
        let scannerLocation = scanner.scanLocation
        _ = scanner.scanUpToString("Z")
        if let  _ = scanner.scanString("Z") {
            return TimeZone.init(secondsFromGMT: 0)
        }

        // If it wasn't Zulu, try to parse out time zone
        scanner.scanLocation = scannerLocation
        let signs = CharacterSet(charactersIn: "+-")
        _ = scanner.scanUpToCharacters(from: signs)
        guard let sign = scanner.scanCharacters(from: signs) else {
            return nil
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

        return TimeZone.init(secondsFromGMT: timeZoneOffset * timeZoneOffsetMultiplier)
    }

    /// An ISO 8601 compliant offset string.
    public var offset: String {
        get {
            if secondsFromGMT() == 0 {
                return "Z"
            }
            let sign: String
            if secondsFromGMT() < 0 {
                sign = "-"
            } else {
                sign = "+"
            }
            let hours = abs(secondsFromGMT()) / (60 * 60)
            let minutes = (abs(secondsFromGMT()) % (60 * 60)) / 60
            return sign + String.init(format: "%02d:%02d", hours, minutes)
        }
    }

}
