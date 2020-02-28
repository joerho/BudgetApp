//
//  HomeViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 2/12/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation

extension HomeViewController {
    class ViewModel {
        
        let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yyyy"
          return formatter
        }()
        
        var expenses: [Expense]
        var incomes: [Income]
        var groupedExpenses: [MonthSection] = []
        var groupedIncomes: [MonthSection] = []
        
        func getMonthlyExpense(date: String) -> Int {
            let month = firstDayOfMonth(date: date)
            for ms in groupedExpenses {
                if ms.month == month{
                    return sumOfTransactions(arr: ms.transactions)
                }
            }
            return 0
        }
        
        func getMonthlyIncome(date: String) -> Int {
            let month = firstDayOfMonth(date: date)
            for ms in groupedIncomes {
                if ms.month == month {
                    return sumOfTransactions(arr: ms.transactions)
                }
            }
            return 0
        }
        
        private func sumOfTransactions(arr: [Transaction]) -> Int {
            var sum = 0
            for t in arr {
                sum += t.amount
            }
            return sum
        }
        
        func firstDayOfMonth(date: String) -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: dateFormatter.date(from: date)!)
            return calendar.date(from: components)!
        }
        
        func separateIntoSections(transactions: [Transaction]) -> [MonthSection] {
            let sections = Dictionary(grouping: transactions) { (expense) -> Date in
                return firstDayOfMonth(date: expense.date)
            }
            var groupedTransactions = sections.map(MonthSection.init(month:transactions:))
            groupedTransactions.sort{(lhs, rhs) in lhs.month > rhs.month}
            
            return groupedTransactions
        }
        
        //MARK: - Life Cycle
        init(expenses: [Expense], incomes: [Income]) {
            self.expenses = expenses
            self.incomes = incomes
            self.groupedExpenses = separateIntoSections(transactions: self.expenses)
            self.groupedIncomes = separateIntoSections(transactions: self.incomes)
        }
    }
}