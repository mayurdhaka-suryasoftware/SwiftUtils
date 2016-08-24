//
//  NSTimeZoneOffsetTests.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/24/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class NSTimeZone_Offset_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testIndia() {
        testFromOffset(actual: NSTimeZone.fromOffset("+0530")!, expected: NSTimeZone.init(name: "Asia/Kolkata")!)
        testFromOffset(actual: NSTimeZone.fromOffset("+05:30")!, expected: NSTimeZone.init(name: "Asia/Kolkata")!)
        XCTAssertEqual(NSTimeZone.init(name: "Asia/Kolkata")?.offset, "+0530")
    }

    func testGMT() {
        testFromOffset(actual: NSTimeZone.fromOffset("+0000")!, expected: NSTimeZone.init(name: "GMT")!)
        testFromOffset(actual: NSTimeZone.fromOffset("Z")!, expected: NSTimeZone.init(name: "GMT")!)
        testFromOffset(actual: NSTimeZone.fromOffset("-0000")!, expected: NSTimeZone.init(name: "GMT")!)
        XCTAssertEqual(NSTimeZone.init(name: "GMT")?.offset, "Z")
    }

    func testArizona() {
        testFromOffset(actual: NSTimeZone.fromOffset("-0700")!, expected: NSTimeZone.init(name: "America/Phoenix")!)
        testFromOffset(actual: NSTimeZone.fromOffset("-07:00")!, expected: NSTimeZone.init(name: "America/Phoenix")!)
        XCTAssertEqual(NSTimeZone.init(name: "America/Phoenix")?.offset, "-0700")
    }

    private func testFromOffset(actual actual: NSTimeZone, expected: NSTimeZone) {
        XCTAssertEqual(actual.secondsFromGMT, expected.secondsFromGMT)
    }

}
