//
//  IncomeViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 11/17/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation

extension IncomeViewController {
    class ViewModel {
        
        struct MonthSection {
            var month: Date
            var incomes: [Income]
        }
        
        private var groupedIncomes: [MonthSection]
        
        private var incomes: [Income] {
            didSet {
                incomes.sort(by: {$0.date > $1.date})
            }
        }
        
        let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yyyy"
          return formatter
        }()
        
        var numberOfSections: Int {
            return groupedIncomes.count
        }
        
        var numberOfIncomes: Int {
            return incomes.count
        }
        
        private func income(at index: Int ) -> Income {
            return incomes[index]
        }
        
        private func section(at index: Int) -> MonthSection {
            return groupedIncomes[index]
        }
        
        private func firstDayOfMonth(date: String) -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: dateFormatter.date(from: date)!)
            return calendar.date(from: components)!
            
        }
        
        func sectionIncomes(at index: Int) -> [Income] {
            return groupedIncomes[index].incomes
        }
        
        func sectionCount(at index: Int) -> Int {
            if (groupedIncomes.isEmpty) {
                return 0
            }
            return section(at: index).incomes.count
        }
        
        func sectionTitle(at index: Int) -> String {
            let date = section(at: index).month
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            return dateFormatter.string(from: date)
        }
        
        func amount(at indexPath: IndexPath) -> String {
            let income = section(at: indexPath.section).incomes[indexPath.row]
            let amount = Double(income.amount / 100)
            return "$" + String(format: "%.2f", amount)
        }
        
        func description(at indexPath: IndexPath) -> String {
            let income = section(at: indexPath.section).incomes[indexPath.row]
            return income.description
        }
        
        func dateText(at indexPath: IndexPath) -> String {
            let income = section(at: indexPath.section).incomes[indexPath.row]
            return income.date
        }
        
        func editIncomeViewModel(at index: Int) -> AddNewIncomeViewController.ViewModel {
            let incomeModel = income(at: index)
            let editViewModel = AddNewIncomeViewController.ViewModel(income: incomeModel)
            return editViewModel
        }
        
        func addNewIncomeViewModel() -> AddNewIncomeViewController.ViewModel {
            let income = Income()
            let addViewModel = AddNewIncomeViewController.ViewModel(income: income)
            return addViewModel
        }
        
        func separateIntoSections() {
            let sections = Dictionary(grouping: incomes) { (income) -> Date in
                return firstDayOfMonth(date: income.date)
            }
            groupedIncomes = sections.map(MonthSection.init(month:incomes:))
            groupedIncomes.sort{(lhs, rhs) in lhs.month > rhs.month}
        }
        
        // MARK: - Database Interaction Methods
        func deleteIncome(at indexPath: IndexPath) {
            let income = section(at: indexPath.section).incomes[indexPath.row]
            Database.instance.deleteIncome(incomeModel: income)
            if let index = incomes.firstIndex(of: income) {
                incomes.remove(at: index)
            }
            separateIntoSections()
        }
        
        func updateIncome(income: Income) {
            Database.instance.updateIncome(incomeModel: income)
        }
        
        func addIncome(income: Income) {
            Database.instance.addIncome(incomeModel: income)
            incomes.append(income)
            separateIntoSections()
        }
        
// MARK: - Life Cycle
        init(incomes: [Income]) {
            self.incomes = incomes
            self.incomes.sort(by: {$0.date > $1.date})
            self.groupedIncomes = []
            
            separateIntoSections()
        }
    }
}
