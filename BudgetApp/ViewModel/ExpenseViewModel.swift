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
            var expenses: [Expense]
        }
        
        private var groupedExpenses: [MonthSection]
        
        private var expenses: [Expense] {
            didSet{
                expenses.sort(by: {$0.date > $1.date })
            }
        }
        
        let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yyyy"
          return formatter
        }()
        
        var numberOfSections: Int {
            return groupedExpenses.count
        }

        var numberOfExpenses: Int {
            return expenses.count
        }

        private func expense(at index: Int) -> Expense {
            return expenses[index]
        }
        
        private func section(at index: Int) -> MonthSection {
            return groupedExpenses[index]
        }
        
        private func firstDayOfMonth(date: String) -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: dateFormatter.date(from: date)!)
            return calendar.date(from: components)!
            
        }
        
        func sectionExpenses(at index: Int) -> [Expense] {
            return groupedExpenses[index].expenses
        }
        
        func sectionCount(at index: Int) -> Int {
            if (groupedExpenses.isEmpty) {
                return 0
            }
            return section(at: index).expenses.count
        }
        
        func sectionTitle(at index: Int) -> String {
            let date = section(at: index).month
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            return dateFormatter.string(from: date)
        }
        
        func amount(at indexPath: IndexPath) -> String {
            let expense = section(at: indexPath.section).expenses[indexPath.row]
            let amount = Double(expense.amount) / 100
            return "$" + String(format: "%.2f", amount)
        }
        
        func description(at indexPath: IndexPath) -> String {
            let expense = section(at: indexPath.section).expenses[indexPath.row]
            return expense.description
        }
        
        func dateText(at indexPath: IndexPath) -> String {
            let expense = section(at: indexPath.section).expenses[indexPath.row]
            return expense.date
        }

        func editViewModel(at indexPath: IndexPath) -> AddNewExpenseViewController.ViewModel {
            let expense = section(at: indexPath.section).expenses[indexPath.row]
            let editViewModel = AddNewExpenseViewController.ViewModel(expense: expense)
            return editViewModel
        }
        
        func addNewExpenseViewModel() -> AddNewExpenseViewController.ViewModel {
            let expense = Expense()
            let addViewModel = AddNewExpenseViewController.ViewModel(expense: expense)
            return addViewModel
        }
        
        //groups expenses into a list of MonthSection struct
        func separateIntoSections() {
            let sections = Dictionary(grouping: expenses) { (expense) -> Date in
                return firstDayOfMonth(date: expense.date)
            }
            groupedExpenses = sections.map(MonthSection.init(month:expenses:))
            groupedExpenses.sort{(lhs, rhs) in lhs.month > rhs.month}
        }
        
        // MARK: - Database Interaction Methods

        func deleteExpense(at indexPath: IndexPath) {
            let expense = section(at: indexPath.section).expenses[indexPath.row]
            Database.instance.deleteExpense(expense: expense)
            if let index = expenses.firstIndex(of: expense) {
                expenses.remove(at: index)
            }
            separateIntoSections()
        }
        
        func updateExpense(expense: Expense) {
            Database.instance.updateExpense(expense: expense)
        }
        
        // changes should reflect on groupedExpense
        func addExpense(expense: Expense) {
            Database.instance.addExpense(expense: expense)
            expenses.append(expense)
            separateIntoSections()
        }
        
        
        // MARK: - Life Cycle
        init(expenses: [Expense]) {
            self.expenses = expenses
            self.expenses.sort(by: {$0.date > $1.date })
            self.groupedExpenses = []
            
            separateIntoSections()
        }
    }
}
