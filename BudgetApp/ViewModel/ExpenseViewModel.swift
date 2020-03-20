//
//  ExpenseViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 10/21/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


extension ExpenseViewController {
    
    class ViewModel : BaseViewModel {

        func editViewModel(at indexPath: IndexPath) -> AddNewExpenseViewController.ViewModel {
            let expense = section(at: indexPath.section).transactions[indexPath.row]
            let editViewModel = AddNewExpenseViewController.ViewModel(expense: expense as! Expense)
            
            return editViewModel
        }
        
        func addNewExpenseViewModel() -> AddNewExpenseViewController.ViewModel {
            let expense = Expense()
            let addViewModel = AddNewExpenseViewController.ViewModel(expense: expense)
            
            return addViewModel
        }
        
        // MARK: - Database Interaction Methods

        func deleteExpense(at indexPath: IndexPath) {
            let expense = section(at: indexPath.section).transactions[indexPath.row]
            Database.instance.deleteExpense(expense: expense as! Expense)
            if let index = transactions.firstIndex(of: expense) {
                transactions.remove(at: index)
            }
            self.groupedTransactions = separateIntoSections(transactions: self.transactions)
        }
        
        func updateExpense(expense: Expense) {
            Database.instance.updateExpense(expense: expense)
        }
        
        func addExpense(expense: Expense) {
            expense.id = Database.instance.addExpense(expense: expense)
            transactions.append(expense)
            self.groupedTransactions = separateIntoSections(transactions: self.transactions)
        }
        
        
        // MARK: - Life Cycle
        init(expenses: [Expense]) {
            super.init(transactions: expenses)
        }
    }
}
