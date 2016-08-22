//
//  WeakBox.swift
//  SwiftUtils
//
//  Created by Gopal Sharma on 8/22/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import Foundation

/**
 *  Boxes a weak reference to an object.
 *
 *  This is useful when you want to hold a strong container of weak references.
 */
public struct WeakBox<T: AnyObject> {
    public weak var value: T?

    init(value: T) {
        self.value = value
    }

}
