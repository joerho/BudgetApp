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
        
        struct MonthSection {
            var month: Date
            var transactions: [Transaction]
        }
        
        private var groupedTransactions: [MonthSection]
        
        private var transactions: [Transaction] {
            didSet{
                transactions.sort(by: {$0.date > $1.date })
            }
        }
        
        let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yyyy"
          return formatter
        }()
        
        var numberOfSections: Int {
            return groupedTransactions.count
        }

        var numberOfTransactions: Int {
            return transactions.count
        }

        private func transaction(at index: Int) -> Transaction {
            return transactions[index]
        }
        
        private func section(at index: Int) -> MonthSection {
            return groupedTransactions[index]
        }
        
        private func firstDayOfMonth(date: String) -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: dateFormatter.date(from: date)!)
            return calendar.date(from: components)!
            
        }
        
        func sectionTransactions(at index: Int) -> [Transaction] {
            return groupedTransactions[index].transactions
        }
        func sectionCount(at index: Int) -> Int {
            return section(at: index).transactions.count
        }
        func sectionTitle(at index: Int) -> String {
            let date = section(at: index).month
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            return dateFormatter.string(from: date)
        }
        
        func amount(at indexPath: IndexPath) -> String {
            let transaction = section(at: indexPath.section).transactions[indexPath.row]
            let amount = Double(transaction.amount) / 100
            return "$" + String(format: "%.2f", amount)
        }
        
        func description(at indexPath: IndexPath) -> String {
            let transaction = section(at: indexPath.section).transactions[indexPath.row]
            return transaction.description
        }
        
        func dateText(at indexPath: IndexPath) -> String {
            let transaction = section(at: indexPath.section).transactions[indexPath.row]
            return transaction.date
        }
//
//        func amount(at index: Int) -> String {
//            let amount = Double(transactions[index].amount) / 100
//            return "$" + String(format: "%.2f", amount)
//        }
//
//
//        func description(at index: Int) -> String {
//            return transaction(at: index).description
//        }
//
//        func dateText(at index: Int) -> String {
//            return transaction(at: index).date
//        }
//
        func editViewModel(at index: Int) -> AddNewTransactionViewController.ViewModel {
            let transaction = self.transaction(at: index)
            let editViewModel = AddNewTransactionViewController.ViewModel(transaction: transaction)
            return editViewModel
        }
        
        func addNewTransactionViewModel() -> AddNewTransactionViewController.ViewModel {
            let transaction = Transaction()
            let addViewModel = AddNewTransactionViewController.ViewModel(transaction: transaction)
            return addViewModel
        }
        
        func deleteTransaction(at index: Int) {
            Database.instance.deleteExpense(transaction: transaction(at: index))
            transactions.remove(at: index)
        }
        
        func updateTransaction(transaction: Transaction) {
            Database.instance.updateExpense(transaction: transaction)
        }
        
        func addTransaction(transaction: Transaction) {
            Database.instance.addExpense(transaction: transaction)
            transactions.append(transaction)
        }
        
        
// MARK: - Life Cycle
        init(transactions: [Transaction]) {
            self.transactions = transactions
            self.transactions.sort(by: {$0.date > $1.date })
            self.groupedTransactions = []
            
            let sections = Dictionary(grouping: transactions) { (transaction) -> Date in
                return firstDayOfMonth(date: transaction.date)
            }
            
            self.groupedTransactions = sections.map(MonthSection.init(month:transactions:))
            self.groupedTransactions.sort{(lhs, rhs) in lhs.month > rhs.month}
        }
    }
}
