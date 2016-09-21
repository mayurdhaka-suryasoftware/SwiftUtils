//
//  TimeZoneOffsetTests.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class TimeZone_Offset_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testIndia() {
        testFromOffset(actual: TimeZone.from(offset: "+0530")!, expected: TimeZone.init(identifier: "Asia/Kolkata")!)
        testFromOffset(actual: TimeZone.from(offset: "+05:30")!, expected: TimeZone.init(identifier: "Asia/Kolkata")!)
        XCTAssertEqual(TimeZone.init(identifier: "Asia/Kolkata")?.offset, "+05:30")
    }

    func testGMT() {
        testFromOffset(actual: TimeZone.from(offset: "+0000")!, expected: TimeZone.init(identifier: "GMT")!)
        testFromOffset(actual: TimeZone.from(offset: "Z")!, expected: TimeZone.init(identifier: "GMT")!)
        testFromOffset(actual: TimeZone.from(offset: "-0000")!, expected: TimeZone.init(identifier: "GMT")!)
        XCTAssertEqual(TimeZone.init(identifier: "GMT")?.offset, "Z")
    }

    func testArizona() {
        testFromOffset(actual: TimeZone.from(offset: "-0700")!, expected: TimeZone.init(identifier: "America/Phoenix")!)
        testFromOffset(actual: TimeZone.from(offset: "-07:00")!, expected: TimeZone.init(identifier: "America/Phoenix")!)
        XCTAssertEqual(TimeZone.init(identifier: "America/Phoenix")?.offset, "-07:00")
    }

    fileprivate func testFromOffset(actual: TimeZone, expected: TimeZone) {
        XCTAssertEqual(actual.secondsFromGMT(), expected.secondsFromGMT())
    }

}
