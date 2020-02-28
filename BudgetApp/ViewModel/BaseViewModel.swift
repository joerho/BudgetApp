//
//  BaseViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 2/5/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation

class BaseViewModel {
    
    let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter
    }()
    
    var groupedTransactions: [MonthSection] = []
    
    var transactions: [Transaction] {
        didSet{
            transactions.sort(by: {$0.date > $1.date })
        }
    }
    
    var numberOfTransactions: Int {
        return transactions.count
    }
    
    var numberOfSections: Int {
        return groupedTransactions.count
    }

    private func transaction(at index: Int) -> Transaction {
        return transactions[index]
    }
    
    func section(at index: Int) -> MonthSection {
        return groupedTransactions[index]
    }
    
    
    func firstDayOfMonth(date: String) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: dateFormatter.date(from: date)!)
        return calendar.date(from: components)!
    }
    
    func sectionTitle(at index: Int) -> String {
        let date = section(at: index).month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func sectionExpenses(at index: Int) -> [Transaction] {
        return groupedTransactions[index].transactions
    }
    
    func sectionCount(at index: Int) -> Int {
        if (groupedTransactions.isEmpty) {
            return 0
        }
        return section(at: index).transactions.count
    }
    
    //groups expenses into a list of MonthSection struct
    func separateIntoSections(transactions: [Transaction]) -> [MonthSection] {
        let sections = Dictionary(grouping: transactions) { (expense) -> Date in
            return firstDayOfMonth(date: expense.date)
        }
        var groupedTransactions = sections.map(MonthSection.init(month:transactions:))
        groupedTransactions.sort{(lhs, rhs) in lhs.month > rhs.month}
        
        return groupedTransactions
    }
    
    func amount(at indexPath: IndexPath) -> String {
        let expense = section(at: indexPath.section).transactions[indexPath.row]
        let amount = Double(expense.amount) / 100
        return "$" + String(format: "%.2f", amount)
    }
    
    func description(at indexPath: IndexPath) -> String {
        let expense = section(at: indexPath.section).transactions[indexPath.row]
        return expense.description
    }
    
    func dateText(at indexPath: IndexPath) -> String {
        let expense = section(at: indexPath.section).transactions[indexPath.row]
        return expense.date
    }
    
    //MARK: - Life Cycle
    init(transactions: [Transaction]) {
        self.transactions = transactions
        self.transactions.sort(by: {$0.date > $1.date})
        self.groupedTransactions = separateIntoSections(transactions: self.transactions)
        
    }
}
