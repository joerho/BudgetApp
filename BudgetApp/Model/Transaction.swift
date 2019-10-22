//
//  Transaction.swift
//  BudgetApp
//
//  Created by joe rho on 10/7/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


class Transaction {
    var id: Int64?
    var description: String?
    var date: Date
    var amount: NSDecimalNumber
    
    fileprivate var category_raw: String?
    fileprivate var repeats_raw: String
    
    init(id: Int64? = nil, description: String? = nil, date: Date = Date(), amount: NSDecimalNumber = 0.0, category: String? = nil, repeats: String = RepeatFrequency.never.rawValue) {
        self.id = id
        self.description = description
        self.date = date
        self.amount = amount
        self.category_raw = category
        self.repeats_raw = repeats
    }
}


// MARK: - Category

extension Transaction {
    enum Category: String {
        case misc = "Misc."
        case food = "Food"
        case transportation = "Transportation"
        case housing = "Housing"
        case utilities = "Utilities"
        case personal = "Personal"
        case entertainment = "Entertainment"
    }
    
    enum RepeatFrequency: String {
        case never = "Never"
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
        case annually = "Annually"
    }
}


// MARK: - Computed Variables

extension Transaction {
    var category: Category? {
        get {
            if let value = self.category_raw {
                return Category(rawValue: value)!
            }
            return nil
        }
        set {
            self.category_raw = newValue?.rawValue
        }
    }
    
    var repeats: RepeatFrequency {
        get {
            return RepeatFrequency(rawValue: self.repeats_raw)!
        }
        set {
            self.repeats_raw = newValue.rawValue
        }
    }
}

