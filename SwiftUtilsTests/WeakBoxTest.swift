//
//  WeakBoxTest.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/22/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class WeakBoxTest: XCTestCase {

    func testWeakBox() {
        var foo: NSString? = "foo"
        let weakBox = WeakBox.init(value: foo!)
        XCTAssertNotNil(weakBox.value)
        foo = nil
        XCTAssertNil(weakBox.value)
    }

}
