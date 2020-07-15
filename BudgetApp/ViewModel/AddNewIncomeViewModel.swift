//
//  AddNewIncomeViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 11/15/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


extension AddNewIncomeViewController {
    class ViewModel {
        
        private let income: Income
        
        let numberFormatter: CurrencyFormatter = {
            let formatter = CurrencyFormatter()
            formatter.numberStyle = .currency
            formatter.locale = .init(identifier: "en_US_POSIX")
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }()
        
        var id: Int64? {
            get {
                return income.id
            }
        }
        
        var description: String {
            get {
                return income.description
            }
            set {
                income.description = newValue
            }
        }
        
        var amount: Int {
            get {
                return income.amount
            }
            set {
                income.amount = newValue
            }
        }
        
        var date: String {
            get {
                if income.date == "" {
                    income.date = Formatter.mmddyyyy.string(from: Date())
                }
                return income.date
            }
            set {
                income.date = newValue
            }
        }
        
        var repeatOptions: [String] = [
            Income.RepeatFrequency.never.rawValue,
            Income.RepeatFrequency.daily.rawValue,
            Income.RepeatFrequency.weekly.rawValue,
            Income.RepeatFrequency.biweekly.rawValue,
            Income.RepeatFrequency.monthly.rawValue,
            Income.RepeatFrequency.annually.rawValue,
        ]
        
        var repeats: String {
            get {
                return income.repeats.rawValue
            }
            set {
                income.repeats = Expense.RepeatFrequency(rawValue: newValue)!
            }
        }
        
        func getIncome() -> Income {
            return self.income
        }
        
        // MARK: - Life Cycle
        init(income: Income) {
            self.income = income
        }
        
        
    }
}
