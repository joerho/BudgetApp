//
//  Repeat.swift
//  BudgetApp
//
//  Created by joe rho on 6/10/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation

class Repeat {
    var id: Int64?
    var type: Int
    var fk_id: Int64
    var max_num_of_occurrences: Int
    var recurring_type: Int
    var separation_count: Int
    var day_of_week: Int
    var week_of_month: Int
    var month_of_year: Int
    
    init(id: Int64? = nil, type: Int, fk_id: Int64, max_num_of_occurrences: Int, recurring_type: Int, separation_count: Int, day_of_week: Int, week_of_month: Int, month_of_year: Int) {
        self.id = id
        self.type = type
        self.fk_id = fk_id
        self.max_num_of_occurrences = max_num_of_occurrences
        self.recurring_type = recurring_type
        self.separation_count = separation_count
        self.day_of_week = day_of_week
        self.week_of_month = week_of_month
        self.month_of_year = month_of_year
    }
}
