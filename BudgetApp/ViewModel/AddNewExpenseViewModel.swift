//
//  ExpenseViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 10/16/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


extension AddNewExpenseViewController {
    
    class ViewModel {
        
        private let expense: Expense
        
        let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yyyy"
          return formatter
        }()
        
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
                return expense.id
            }
        }
        
        var description: String {
            get {
                return expense.description
            }
            set {
                expense.description = newValue
            }
        }
        
        var amount: Int {
            get {
                return expense.amount
            }
            set {
                expense.amount = newValue
            }
        }
        
        var date: String {
            get {
                if expense.date == "" {
                    expense.date = dateFormatter.string(from: Date())
                }
                return expense.date
            }
            set {
                expense.date = newValue
            }
        }
        
        var categoryOptions: [String] = [
            Expense.Category.misc.rawValue,
            Expense.Category.food.rawValue,
            Expense.Category.transportation.rawValue,
            Expense.Category.housing.rawValue,
            Expense.Category.utilities.rawValue,
            Expense.Category.personal.rawValue,
            Expense.Category.entertainment.rawValue,
        ]
        
        var category: String {
            get {
                return expense.category.rawValue
            }
            set {
                expense.category = Expense.Category(rawValue: newValue)!
            }
        }
        
        var repeatOptions: [String] = [
            Expense.RepeatFrequency.never.rawValue,
            Expense.RepeatFrequency.daily.rawValue,
            Expense.RepeatFrequency.weekly.rawValue,
            Expense.RepeatFrequency.monthly.rawValue,
            Expense.RepeatFrequency.annually.rawValue,
        ]
        
        var repeats: String {
            get {
                return expense.repeats.rawValue
            }
            set {
                expense.repeats = Expense.RepeatFrequency(rawValue: newValue)!
            }
        }
        
        // MARK: - Life Cycle
        
        init(expense: Expense) {
            self.expense = expense
        }
        
        // MARK: - Action
        func getExpense() -> Expense {
            return self.expense
        }
        
    }
    
}
