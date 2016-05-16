//
//  String+Localized.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 5/16/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import Foundation

extension String {

    public func localized(comment: String = "") -> String {
        // TODO: Write unit tests for this
        return NSLocalizedString(self, comment: comment)
    }

}
