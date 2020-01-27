//
//  Transaction.swift
//  BudgetApp
//
//  Created by joe rho on 10/7/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


class Transaction: Comparable {
    
    
    var id: Int64?
    var description: String
    var date: String
    var amount: Int
    
    init(id: Int64? = nil, description: String = "", date: String = "", amount: Int = 0) {
        self.id = id
        self.description = description
        self.date = date
        self.amount = amount
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


