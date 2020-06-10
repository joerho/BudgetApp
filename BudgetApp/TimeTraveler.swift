//
//  TimeTraveler.swift
//  BudgetApp
//
//  Created by joe rho on 6/8/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation

class TimeTraveler {
    private var date = Date()
    
    func travel(timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }
    
    func generateDate() -> Date {
        return date
    }
}
