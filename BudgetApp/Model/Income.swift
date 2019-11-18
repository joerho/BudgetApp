//
//  Income.swift
//  BudgetApp
//
//  Created by joe rho on 11/13/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


class Income {
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
}

