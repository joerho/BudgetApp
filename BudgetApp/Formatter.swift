//
//  Formatter.swift
//  BudgetApp
//
//  Created by joe rho on 6/26/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation

extension Formatter {
    static let mmddyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    static let mediumDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
