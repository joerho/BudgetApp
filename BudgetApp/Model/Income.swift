//
//  Income.swift
//  BudgetApp
//
//  Created by joe rho on 11/13/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


class Income: Transaction {
    override init(id: Int64? = nil, description: String = "", date: String = "", amount: Int = 0) {
        super.init(id: id, description: description, date: date, amount: amount)
    }
}

