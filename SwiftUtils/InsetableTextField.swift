//
//  InsetableTextField.swift
//  SwiftUtils
//
//  Created by Chetan M on 18/08/16.
//  Copyright © 2016 Gopal Sharma. All rights reserved.
//

import UIKit


// This subclass of UITextField will add the edgeInsets only for the text area of the textField.
open class InsetableTextField: UITextField {

    open var edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, self.edgeInsets))
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: UIEdgeInsetsInsetRect(bounds, self.edgeInsets))
    }

}
