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
        
        
        // MARK: - Life Cycle
        
        init(transaction: Transaction) {
            self.transaction = transaction
        }
    }
    
    
    
    
    
    
    
    
    
}
