//
//  TransactionViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 10/16/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


extension AddNewTransactionViewController {
    
    class ViewModel {
        
        private let transaction: Transaction
        
        var description: String? {
            get {
                return transaction.description
            }
            set {
                transaction.description = newValue
            }
        }
        
        var amount: NSDecimalNumber {
            get {
                return transaction.amount
            }
            set {
                transaction.amount = newValue
            }
        }
        
        var date: Date {
            get {
                return transaction.date
            }
            set {
                transaction.date = newValue
            }
        }
        
        var categoryOptions: [String] = [
            Transaction.Category.misc.rawValue,
            Transaction.Category.food.rawValue,
            Transaction.Category.transportation.rawValue,
            Transaction.Category.housing.rawValue,
            Transaction.Category.utilities.rawValue,
            Transaction.Category.personal.rawValue,
            Transaction.Category.entertainment.rawValue,
        ]
        
        var category: String? {
            get {
                return transaction.category?.rawValue
            }
            set {
                if let value = newValue {
                    transaction.category = Transaction.Category(rawValue: value)!
                }
            }
        }
        
        var repeatOptions: [String] = [
            Transaction.RepeatFrequency.never.rawValue,
            Transaction.RepeatFrequency.daily.rawValue,
            Transaction.RepeatFrequency.weekly.rawValue,
            Transaction.RepeatFrequency.monthly.rawValue,
            Transaction.RepeatFrequency.annually.rawValue,
        ]
        
        var repeats: String {
            get {
                return transaction.repeats.rawValue
            }
            set {
                transaction.repeats = Transaction.RepeatFrequency(rawValue: newValue)!
            }
        }
        
        
        // MARK: - Life Cycle
        
        init(transaction: Transaction) {
            self.transaction = transaction
        }
    }
    
    
    
    
    
    
    
    
    
}
