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
            //formatter.generatesDecimalNumbers = true
            
            return formatter
        }()
        
        var id: Int64? {
            get {
                return transaction.id
            }
        }
        
        var description: String {
            get {
                return transaction.description
            }
            set {
                transaction.description = newValue
            }
        }
        
        var amount: Int {
            get {
                return transaction.amount
            }
            set {
                transaction.amount = newValue
            }
        }
        
        var date: String {
            get {
                if transaction.date == "" {
                    transaction.date = dateFormatter.string(from: Date())
                }
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
        
        var category: String {
            get {
                return transaction.category.rawValue
            }
            set {
                transaction.category = Transaction.Category(rawValue: newValue)!
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
        
        // MARK: - Action
        func getTransaction() -> Transaction {
            return self.transaction
        }
        
    }
    
    
    
    
    
    
    
    
    
}
