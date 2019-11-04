//
//  ExpenseViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 10/21/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


extension ExpenseViewController {
    
    
    class ViewModel {
        private var transactions: [Transaction]
        
        var numberOfTransactions: Int {
            return transactions.count
        }

        private func transaction(at index: Int) -> Transaction {
            return transactions[index]
        }
        
        func description(at index: Int) -> String {
            return transaction(at: index).description ?? ""
        }
        
        func dateText(at index: Int) -> String {
            return transaction(at: index).date
        }
        
        func editViewModel(at index: Int) -> AddNewTransactionViewController.ViewModel {
            let transaction = self.transaction(at: index)
            let editViewModel = AddNewTransactionViewController.ViewModel(transaction: transaction)
            return editViewModel
        }
        
        func addNewTransactionViewModel() -> AddNewTransactionViewController.ViewModel {
            let transaction = Transaction()
            transactions.append(transaction)
            let addViewModel = AddNewTransactionViewController.ViewModel(transaction: transaction)
            return addViewModel
        }
        
        func removeLastTransaction() {
            print(numberOfTransactions)
            print(transactions.endIndex)
            transactions.remove(at: transactions.endIndex - 1)
        }
        
        // MARK: - Life Cycle
        init(transactions: [Transaction]) {
            self.transactions = transactions
        }
    }
}
