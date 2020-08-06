//
//  RepeatsViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 7/21/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation

extension RepeatsViewController {
    class ViewModel {
        
        var repeats: [Repeat]
        var expenses: [Expense]
        var incomes: [Income]
        
        var numberOfRepeats: Int {
            return repeats.count
        }
        
        func amount(at indexPath: IndexPath) -> String {
            let repeatInstance = repeats[indexPath.row]
            let type = repeatInstance.type
            let fk_id = repeatInstance.fk_id
            let transaction = getTransaction(type: type, fk_id: fk_id)
            let amount = transaction.amount
            
            return "$" + String(format: "%.2f", amount)
        }
        
        func description(at indexPath: IndexPath) -> String {
            let repeatInstance = repeats[indexPath.row]
            let type = repeatInstance.type
            let fk_id = repeatInstance.fk_id
            let transaction = getTransaction(type: type, fk_id: fk_id)
            
            return transaction.description
        }
        
        func frequency(at indexPath: IndexPath) -> String {
            let repeatInstance = repeats[indexPath.row]
            let recurring_type = repeatInstance.recurring_type
            
            return getFrequency(recurring_type: recurring_type)
        }
        
        func start_date(at indexPath: IndexPath) -> String {
            let repeatInstance = repeats[indexPath.row]
            let type = repeatInstance.type
            let fk_id = repeatInstance.fk_id
            let transaction = getTransaction(type: type, fk_id: fk_id)
            
            return transaction.date
        }
        
        func repeat_type(at indexPath: IndexPath) -> String {
            let repeatInstance = repeats[indexPath.row]
            let type = repeatInstance.type
            
            if type == 0 {
                return "Expense"
            }
            else {
                return "Income"
            }
        }
        
        // Modify this function for
        func getFrequency(recurring_type: Int) -> String {
            switch recurring_type {
            case 0:
                return "Daily"
            case 1:
                return "Weekly"
            case 2:
                return "Biweekly"
            case 3:
                return "Monthly"
            case 4:
                return "Yearly"
            default:
                return "?"
            }
        }
        
        func getTransaction(type: Int, fk_id: Int64) -> Transaction {
            if type == 0 {
                return getExpense(with: fk_id)
            }
            else {
                return getIncome(with: fk_id)
            }
        }
        
        func getExpense(with fk_id: Int64) -> Expense! {
            for expense in expenses {
                if expense.id == fk_id {
                    return expense
                }
            }
            return nil
        }
        
        func getIncome(with fk_id: Int64) -> Income! {
            for income in incomes {
                if income.id == fk_id {
                    return income
                }
            }
            return nil
        }
        
        
        
        init(repeats: [Repeat], expenses: [Expense], incomes: [Income]) {
            self.repeats = repeats
            self.expenses = expenses
            self.incomes = incomes
        }
    }
}
