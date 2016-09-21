//
//  JSONTests.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 9/20/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class JSONTests: XCTestCase {

    func testInitFromString() throws {
        let json = try JSON(string: "{\"hello\": \"world\"}")
        XCTAssertEqual("world", try json.string(forKey: "hello"))
    }

}
