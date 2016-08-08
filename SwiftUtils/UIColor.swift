//
//  UIColor.swift
//  SwiftUtils
//
//  Created by Chetan M on 20/07/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import UIKit

public extension UIColor {

    convenience init?(hexString: String) {
        let hexString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner = NSScanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        guard let color = scanner.scanHexInt() else {
            return nil
        }

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

}
