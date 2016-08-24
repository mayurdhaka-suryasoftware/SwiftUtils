//
//  NSDateComponents+Offset-Tests.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class NSDateComponents_Offset_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testIndiaToGMT() {
        let original = NSDateComponents.init()
        original.calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        original.year = 2016
        original.month = 8
        original.day = 24
        original.hour = 5
        original.minute = 30
        original.second = 0
        original.timeZone = NSTimeZone.init(name: "Asia/Kolkata")
        let date = original.date!

        let actual = NSDateComponents.fromDate(date, inTimezoneOffset: "Z")!
        XCTAssertEqual(2016, actual.year)
        XCTAssertEqual(8, actual.month)
        XCTAssertEqual(24, actual.day)
        XCTAssertEqual(0, actual.hour)
        XCTAssertEqual(0, actual.minute)
        XCTAssertEqual(0, actual.second)
        XCTAssertEqual(0, actual.timeZone!.secondsFromGMT)
        XCTAssertNotNil(actual.date)
    }

    func testGMTToIndia() {
        let original = NSDateComponents.init()
        original.calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        original.year = 2016
        original.month = 8
        original.day = 24
        original.hour = 0
        original.minute = 0
        original.second = 0
        original.timeZone = NSTimeZone.init(name: "GMT")
        let date = original.date!

        let actual = NSDateComponents.fromDate(date, inTimezoneOffset: "+0530")!
        XCTAssertEqual(2016, actual.year)
        XCTAssertEqual(8, actual.month)
        XCTAssertEqual(24, actual.day)
        XCTAssertEqual(5, actual.hour)
        XCTAssertEqual(30, actual.minute)
        XCTAssertEqual(0, actual.second)
        XCTAssertEqual(NSTimeZone.fromOffset("+0530")!.secondsFromGMT, actual.timeZone!.secondsFromGMT)
        XCTAssertNotNil(actual.date)
    }

    func testArizonaToIndia() {
        let original = NSDateComponents.init()
        original.calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        original.year = 2016
        original.month = 8
        original.day = 24
        original.hour = 23
        original.minute = 0
        original.second = 0
        original.timeZone = NSTimeZone.init(name: "America/Phoenix")
        let date = original.date!

        let actual = NSDateComponents.fromDate(date, inTimezoneOffset: "+0530")!
        XCTAssertEqual(2016, actual.year)
        XCTAssertEqual(8, actual.month)
        XCTAssertEqual(25, actual.day)
        XCTAssertEqual(11, actual.hour)
        XCTAssertEqual(30, actual.minute)
        XCTAssertEqual(0, actual.second)
        XCTAssertEqual(NSTimeZone.fromOffset("+0530")!.secondsFromGMT, actual.timeZone!.secondsFromGMT)
        XCTAssertNotNil(actual.date)
    }

}
