//
//  UIColor-Tests.swift
//  SwiftUtils
//
//  Created by Chetan M on 20/07/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import XCTest

class UIColor_Tests: XCTestCase {

    func testColorWithHexString() {
        let color = UIColor(hexString: "#3B3F40")
        let RGBColor = UIColor(red: 59/255, green: 63/255, blue: 64/255, alpha: 1)
        XCTAssertEqual(color, RGBColor)
    }
}
