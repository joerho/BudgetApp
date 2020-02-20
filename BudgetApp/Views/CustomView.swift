//
//  CustomView.swift
//  BudgetApp
//
//  Created by joe rho on 2/19/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation
import UIKit


class CustomView: UIView {
    var height = 1.0
    
    override open var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 1.0, height: height)
        }
    }
    
}
