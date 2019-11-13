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
        
        func amount(at index: Int) -> String {
            let amount = Double(transactions[index].amount) / 100
            return "$" + String(format: "%.2f", amount)
        }
        
        
        func description(at index: Int) -> String {
            return transaction(at: index).description
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
            //transactions.append(transaction)
            let addViewModel = AddNewTransactionViewController.ViewModel(transaction: transaction)
            return addViewModel
        }
        
        func addTransaction(transaction: Transaction) {
            transactions.append(transaction)
            transactions.sort(by: {$0.date > $1.date })
        }
        
        // MARK: - Life Cycle
        init(transactions: [Transaction]) {
            self.transactions = transactions
            self.transactions.sort(by: {$0.date > $1.date })
        }
    }
}
