//
//  DateComponents+Offset-Tests.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class DateComponents_Offset_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testIndiaToGMT() {
        var original = DateComponents.init()
        original.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        original.year = 2016
        original.month = 8
        original.day = 24
        original.hour = 5
        original.minute = 30
        original.second = 0
        original.timeZone = TimeZone.init(identifier: "Asia/Kolkata")
        let date = original.date!

        let actual = DateComponents.from(date: date, inTimezoneOffset: "Z")!
        XCTAssertEqual(2016, actual.year)
        XCTAssertEqual(8, actual.month)
        XCTAssertEqual(24, actual.day)
        XCTAssertEqual(0, actual.hour)
        XCTAssertEqual(0, actual.minute)
        XCTAssertEqual(0, actual.second)
        XCTAssertEqual(0, actual.timeZone!.secondsFromGMT())
        XCTAssertNotNil(actual.date)
    }

    func testGMTToIndia() {
        var original = DateComponents.init()
        original.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        original.year = 2016
        original.month = 8
        original.day = 24
        original.hour = 0
        original.minute = 0
        original.second = 0
        original.timeZone = TimeZone.init(identifier: "GMT")
        let date = original.date!

        let actual = DateComponents.from(date: date, inTimezoneOffset: "+0530")!
        XCTAssertEqual(2016, actual.year)
        XCTAssertEqual(8, actual.month)
        XCTAssertEqual(24, actual.day)
        XCTAssertEqual(5, actual.hour)
        XCTAssertEqual(30, actual.minute)
        XCTAssertEqual(0, actual.second)
        XCTAssertEqual(TimeZone.from(offset: "+0530")!.secondsFromGMT(), actual.timeZone!.secondsFromGMT())
        XCTAssertNotNil(actual.date)
    }

    func testArizonaToIndia() {
        var original = DateComponents.init()
        original.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        original.year = 2016
        original.month = 8
        original.day = 24
        original.hour = 23
        original.minute = 0
        original.second = 0
        original.timeZone = TimeZone.init(identifier: "America/Phoenix")
        let date = original.date!

        let actual = DateComponents.from(date: date, inTimezoneOffset: "+0530")!
        XCTAssertEqual(2016, actual.year)
        XCTAssertEqual(8, actual.month)
        XCTAssertEqual(25, actual.day)
        XCTAssertEqual(11, actual.hour)
        XCTAssertEqual(30, actual.minute)
        XCTAssertEqual(0, actual.second)
        XCTAssertEqual(TimeZone.from(offset: "+0530")!.secondsFromGMT(), actual.timeZone!.secondsFromGMT())
        XCTAssertNotNil(actual.date)
    }

}
