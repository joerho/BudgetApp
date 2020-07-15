//
//  Expense.swift
//  BudgetApp
//
//  Created by joe rho on 1/18/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation


class Expense: Transaction {
    fileprivate var category_raw: String
    
    init(id: Int64? = nil, description: String = "", date: String = "", amount: Int = 0, category: String = Category.misc.rawValue, repeats: String = RepeatFrequency.never.rawValue) {
        self.category_raw = category
        super.init(id: id, description: description, date: date, amount: amount, repeats: repeats)
    }
}

// MARK: - Category
extension Expense {
    enum Category: String {
        case misc = "Misc."
        case food = "Food 🍖"
        case transportation = "Transportation 🚗"
        case housing = "Housing 🏠"
        case utilities = "Utilities 🚰"
        case personal = "Personal 👑"
        case entertainment = "Entertainment 🏌️‍♂️"
    }
}

// MARK: - Computed Variables
extension Expense {
    var category: Category {
        get{
            return Category(rawValue: self.category_raw)!
        }
        set {
            self.category_raw = newValue.rawValue
        }
    }
}


