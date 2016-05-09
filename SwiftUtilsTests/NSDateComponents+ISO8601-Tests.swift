//
//  NSDateComponents+ISO8601-Tests.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 5/9/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import Foundation

import XCTest

class NSDateComponentsISO8601: XCTestCase {

    func testDateOnlyDeserialization() {
        testDeserialization("2016-05-08", year: 2016, month: 5, day: 8)
    }

    func testDateAndTimeOnlyDeserialization() {
        testDeserialization("2016-05-08T12:13:54", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54)
        testDeserialization("2016-05-08T12:13:54.45", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54)
        testDeserialization("2016-05-08 12:13:54", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54)
    }

    func testDateTimeAndTimeZoneDeserialization() {
        testDeserialization("2016-05-08T12:13:54+00:00", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: 0)
        testDeserialization("2016-05-08T12:13:54+0000", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: 0)
        testDeserialization("2016-05-08T12:13:54-00:00", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: 0)
        testDeserialization("2016-05-08T12:13:54-0000", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: 0)
        testDeserialization("2016-05-08T12:13:54+05:00", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: 18000)
        testDeserialization("2016-05-08T12:13:54-05:00", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: -18000)
        testDeserialization("2016-05-08T12:13:54+05:30", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: 19800)
        testDeserialization("2016-05-08T12:13:54-05:30", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: -19800)
        testDeserialization("2016-05-08T12:13:54-0530", year: 2016, month: 5, day: 8, hour: 12, minute: 13, second: 54, timeZoneOffset: -19800)
    }

    func testZuluDeserialization() {
        testDeserialization("1999-05-19T23:55:21", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21)
        testDeserialization("1999-05-19T23:55:21+00:00", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-19T23:55:21Z", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
    }

    func testReadingUTC() {
        testDeserialization("1971-02-03T04:05:06.789Z", year: 1971, month: 2, day: 3, hour: 4, minute: 5, second: 6, timeZoneOffset: 0)
        testDeserialization("1971-02-03T04:05:06.78Z", year: 1971, month: 2, day: 3, hour: 4, minute: 5, second: 6, timeZoneOffset: 0)
        testDeserialization("1971-02-03T04:05:06.7Z", year: 1971, month: 2, day: 3, hour: 4, minute: 5, second: 6, timeZoneOffset: 0)
        testDeserialization("1971-02-03T04:05:06Z", year: 1971, month: 2, day: 3, hour: 4, minute: 5, second: 6, timeZoneOffset: 0)
        testDeserialization("1971-02-03T04:05Z", year: 1971, month: 2, day: 3, hour: 4, minute: 5, timeZoneOffset: 0)
        testDeserialization("1970-01-01T00:00:00.000Z", year: 1970, month: 1, day: 1, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1970-06-30T01:06:40.981Z", year: 1970, month: 6, day: 30, hour: 1, minute: 6, second: 40, timeZoneOffset: 0)
        testDeserialization("2058-02-20T18:29:11.100Z", year: 2058, month: 2, day: 20, hour: 18, minute: 29, second: 11, timeZoneOffset: 0)
        testDeserialization("3001-01-01T08:00:00.000Z", year: 3001, month: 1, day: 1, hour: 8, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("2013-02-20T18:29:11.100Z", year: 2013, month: 2, day: 20, hour: 18, minute: 29, second: 11, timeZoneOffset: 0)
    }

    func testTimeZoneDeserialization() {
        testDeserialization("1971-02-03T09:16:06.789+0511", year: 1971, month: 2, day: 3, hour: 9, minute: 16, second: 6, timeZoneOffset: 18660)
        testDeserialization("1971-02-03T09:16:06.78+0511", year: 1971, month: 2, day: 3, hour: 9, minute: 16, second: 6, timeZoneOffset: 18660)
        testDeserialization("1971-02-03T09:16:06.7+0511", year: 1971, month: 2, day: 3, hour: 9, minute: 16, second: 6, timeZoneOffset: 18660)
        testDeserialization("1971-02-03T09:16:06+0511", year: 1971, month: 2, day: 3, hour: 9, minute: 16, second: 6, timeZoneOffset: 18660)
        testDeserialization("1971-02-03T09:16+0511", year: 1971, month: 2, day: 3, hour: 9, minute: 16, timeZoneOffset: 18660)
        testDeserialization("1970-06-29T21:06:40.981-0400", year: 1970, month: 6, day: 29, hour: 21, minute: 6, second: 40, timeZoneOffset: -14400)
        testDeserialization("1969-12-31T16:00:00.000-0800", year: 1969, month: 12, day: 31, hour: 16, minute: 0, second: 0, timeZoneOffset: -28800)
        testDeserialization("2058-02-20T13:29:11.100-0500", year: 2058, month: 2, day: 20, hour: 13, minute: 29, second: 11, timeZoneOffset: -18000)
        testDeserialization("2013-02-20T13:29:11.100-0500", year: 2013, month: 2, day: 20, hour: 13, minute: 29, second: 11, timeZoneOffset: -18000)
        testDeserialization("2013-02-20T13:29:11.100-0501", year: 2013, month: 2, day: 20, hour: 13, minute: 29, second: 11, timeZoneOffset: -18060)
    }

    func testLeapYearDeserialization() {
        testDeserialization("1972-02-29T00:00:00.000Z", year: 1972, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1976-02-29T00:00:00.000Z", year: 1976, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1980-02-29T00:00:00.000Z", year: 1980, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1984-02-29T00:00:00.000Z", year: 1984, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1988-02-29T00:00:00.000Z", year: 1988, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1992-02-29T00:00:00.000Z", year: 1992, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("1996-02-29T00:00:00.000Z", year: 1996, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("2000-02-29T00:00:00.000Z", year: 2000, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("2004-02-29T00:00:00.000Z", year: 2004, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("2008-02-29T00:00:00.000Z", year: 2008, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("2012-02-29T00:00:00.000Z", year: 2012, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
        testDeserialization("2016-02-29T00:00:00.000Z", year: 2016, month: 2, day: 29, hour: 0, minute: 0, second: 0, timeZoneOffset: 0)
    }

    func testDeserializationExtensively() {
        testDeserialization("1999-05-19T23:55:21Z", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-19T23:55:21+09:00", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 9 * 60 * 60)
        testDeserialization("2011-01-31T19:42:36Z", year: 2011, month: 1, day: 31, hour: 19, minute: 42, second: 36, timeZoneOffset: 0)
        testDeserialization("2011-12-13T17:17:00-06:00", year: 2011, month: 12, day: 13, hour: 17, minute: 17, second: 0, timeZoneOffset: -6 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21)
        testDeserialization("1999-05-23 23:55:21+09:00", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 9 * 60 * 60)
        testDeserialization("1999-05-23T23:55:21-09:00", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: -9 * 60 * 60)
        testDeserialization("1999-05-23T23:55:21-09:30", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: -9.5 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21Z", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-23T23:55:21Z", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("-1999-05-23T23:55:21Z", year: -1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("+011985-04-12", year: 11985, month: 4, day: 12)
        testDeserialization("+011985-04-12T10:15:30", year: 11985, month: 4, day: 12, hour: 10, minute: 15, second: 30)
        testDeserialization("-011985-04-12", year: -11985, month: 4, day: 12)
        testDeserialization("-011985-04-12T10:15:30", year: -11985, month: 4, day: 12, hour: 10, minute: 15, second: 30)
        testDeserialization("02-04-12", year: 2, month: 4, day: 12)
        testDeserialization("0002-04-12", year: 2, month: 4, day: 12)
        testDeserialization("2013-06-27T15:39:32.508Z", year: 2013, month: 6, day: 27, hour: 15, minute: 39, second: 32, timeZoneOffset: 0)
        testDeserialization("2014-03-18T20:00:00.000-07:00", year: 2014, month: 3, day: 18, hour: 20, minute: 0, second: 0, timeZoneOffset: -7 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21+0900", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 9 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21-0900", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: -9 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21-1100", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: -11 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21+1400", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 14 * 60 * 60)
        testDeserialization("1999-05-23 23:55:21+0000", year: 1999, month: 5, day: 23, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-19T23:55:21+00:00", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-19T23:55:21-00:00", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-19T23:55:21+0000", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("1999-05-19T23:55:21-0000", year: 1999, month: 5, day: 19, hour: 23, minute: 55, second: 21, timeZoneOffset: 0)
        testDeserialization("2014-03-13", year: 2014, month: 3, day: 13)
        testDeserialization("2014-03-13T10:42:12", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12)
        testDeserialization("2014-03-13T10:42:12", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12)
        testDeserialization("2014-03-13T10:42:12.123", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12)
        testDeserialization("2014-03-13T10:42:12.123Z", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12, timeZoneOffset: 0)
        testDeserialization("2014-03-13T10:42:12Z", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12, timeZoneOffset: 0)
        testDeserialization("2014-03-13T10:42:12.123+07:00", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12, timeZoneOffset: 7 * 60 * 60)
        testDeserialization("2014-03-13T10:42:12.123-09:30", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12, timeZoneOffset: -9.5 * 60 * 60)
        testDeserialization("2014-03-13T10:42:12+07:00", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12, timeZoneOffset: 7 * 60 * 60)
        testDeserialization("2014-03-13T10:42:12-09:30", year: 2014, month: 3, day: 13, hour: 10, minute: 42, second: 12, timeZoneOffset: -9.5 * 60 * 60)
    }

    private func testDeserialization(input: String, year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, timeZoneOffset: NSTimeInterval? = nil) {
        let expected = createDateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second, timeZoneOffset: timeZoneOffset)
        let actual = NSDateComponents(iso8601String: input)
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual!)
    }

    private func createDateComponents(year year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, timeZoneOffset: NSTimeInterval? = nil) -> NSDateComponents {
        let dc = NSDateComponents()

        dc.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)

        if let year = year {
            dc.year = year
        }

        if let month = month {
            dc.month = month
        }

        if let day = day {
            dc.day = day
        }

        if let hour = hour {
            dc.hour = hour
        }

        if let minute = minute {
            dc.minute = minute
        }

        if let second = second {
            dc.second = second
        }

        if let timeZoneOffset = timeZoneOffset {
            dc.timeZone = NSTimeZone(forSecondsFromGMT: Int(timeZoneOffset))
        }

        return dc
    }

}
