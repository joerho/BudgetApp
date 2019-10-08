//
//  Transaction.swift
//  BudgetApp
//
//  Created by joe rho on 10/7/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation



class Transaction {
    let id: Int64?
    let description: String
    let date: NSDate
    let amount: NSDecimalNumber
    let type: Bool //true for income false for expense
    
    init(description: String, date: NSDate, amount: NSDecimalNumber, type: Bool) {
        self.id = nil
        self.description = description
        self.date = date
        self.amount = amount
        self.type = type
    }
    
    init(id: Int64, description: String, date: NSDate, amount: NSDecimalNumber, type: Bool) {
        self.id = id
        self.description = description
        self.date = date
        self.amount = amount
        self.type = type
    }
}

