//
//  Transaction.swift
//  BudgetApp
//
//  Created by joe rho on 10/7/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


class Transaction: Comparable {
    
    fileprivate var repeats_raw: String
    var id: Int64?
    var description: String
    var date: String
    var amount: Int
        
    
    init(id: Int64? = nil, description: String = "", date: String = "", amount: Int = 0, repeats: String = RepeatFrequency.never.rawValue) {
        self.id = id
        self.description = description
        self.date = date
        self.amount = amount
        self.repeats_raw = repeats

    }
    
    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        if (lhs.date < rhs.date) {
            return true
        }
        else {
            return false
        }
    }
    
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        //scared that id will be null
        if (lhs.id == rhs.id) {
            return true
        }
        else {
            return false

        }
    }

}

extension Transaction {
    enum RepeatFrequency: String {
        case never = "Never"
        case daily = "Every Day"
        case weekly = "Every Week"
        case biweekly = "Every 2 Weeks"
        case monthly = "Every Month"
        case annually = "Every Year"
    }
}

extension Transaction {
    var repeats: RepeatFrequency {
        get {
            return RepeatFrequency(rawValue: self.repeats_raw)!
        }
        set {
            self.repeats_raw = newValue.rawValue
        }
    }
}
