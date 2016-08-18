//
//  InsetableTextField.swift
//  SwiftUtils
//
//  Created by Chetan M on 18/08/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import UIKit


// This subclass of UITextField will add the edgeInsets only for the text area of the textField.
public class InsetableTextField: UITextField {

    public var edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        return super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, self.edgeInsets))
    }

    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        return super.editingRectForBounds(UIEdgeInsetsInsetRect(bounds, self.edgeInsets))
    }
    
}
