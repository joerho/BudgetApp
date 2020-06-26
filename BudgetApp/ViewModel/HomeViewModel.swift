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
        
        struct TitleContent {
            var title: String
            var content: String
        }
        
        let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yyyy"
          return formatter
        }()
        
        var expenses: [Expense]
        var incomes: [Income]
        var repeats: [Repeat]
        var groupedExpenses: [MonthSection] = []
        var groupedIncomes: [MonthSection] = []
        var groupedTitleContent: [TitleContent] = []
        
        func getMonthlyExpense(date: String) -> String {
            let month = firstDayOfMonth(date: date)
            for ms in groupedExpenses {
                if ms.month == month{
                    return String(format: "$%.2f", Double(sumOfTransactions(arr: ms.transactions)) / 100)
                }
            }
            return "?"
        }
        
        func getCurrentMonthlyIncome() -> String {
            return getMonthlyIncome(date: dateFormatter.string(from: Date()))
        }
        
        func getCurrentMonthlyExpense() -> String {
            return getMonthlyExpense(date: dateFormatter.string(from: Date()))
        }
        
        func getMonthlyIncome(date: String) -> String {
            let month = firstDayOfMonth(date: date)
            for ms in groupedIncomes {
                if ms.month == month {
                    return String(format: "$%.2f", Double(sumOfTransactions(arr: ms.transactions)) / 100)
                }
            }
            
            return "?"
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
        
        func getTitleContent() -> [TitleContent] {
            var groupedTitleContent: [TitleContent] = []
            groupedTitleContent.append(TitleContent.init(title: "Total Expense", content: getCurrentMonthlyExpense()))
            groupedTitleContent.append(TitleContent.init(title: "Total Income", content: getCurrentMonthlyIncome()))
            
            return groupedTitleContent
        }
        
        func getCurrentMonthYear() -> String {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            return dateFormatter.string(from: date)
        }
        
        private func repeatHandler() {
            if let last_opened_date = UserDefaults.standard.object(forKey: "lastOpened") as? Date {
                let last_opened_string = dateFormatter.string(from: last_opened_date)
                for r in repeats {
                    let type = r.type
                    let fk_id = r.fk_id
                    let max_occurrences = r.max_num_of_occurrences
                    let recurring_type = r.recurring_type
                    let separation_count = r.separation_count
                    let day_of_week = r.day_of_week
                    let week_of_month = r.week_of_month
                    let month_of_year = r.month_of_year
                    let transaction = type == 0 ? getMatchingTransaction(fk_id: fk_id, arr: expenses) :
                                                  getMatchingTransaction(fk_id: fk_id, arr: incomes)
                    
                    switch recurring_type {
                    case 0:
                        dailyRepeat(last_opened: last_opened_string, separation_count: separation_count, transaction: transaction!, type: type)
                    case 1:
                        weeklyRepeat(last_opened: last_opened_string, day_of_week: day_of_week, separation_count: separation_count, transaction: transaction!, type: type)
                    case 2:
                        monthlyRepeat(last_opened: last_opened_string, day_of_week: day_of_week, week_of_month: week_of_month, separation_count: separation_count, transaction: transaction!, type: type)
                    case 3:
                        yearlyRepeat(last_opened: last_opened_string, day_of_week: day_of_week, week_of_month: week_of_month, month_of_year: month_of_year, separation_count: separation_count, transaction: transaction!, type: type)
                    default:
                        break
                    }
                }
            }
        }
        
        private func dailyRepeat(last_opened: String, separation_count: Int, transaction: Transaction, type: Int) {
            //Fill gaps from last opened date to current date
            
        }
        
        private func weeklyRepeat(last_opened: String, day_of_week: Int, separation_count: Int,
                                  transaction: Transaction, type: Int) {
            
        }
        
        private func monthlyRepeat(last_opened: String, day_of_week: Int, week_of_month: Int, separation_count: Int,
                                   transaction: Transaction, type: Int) {
            
        }
        
        private func yearlyRepeat(last_opened: String, day_of_week: Int, week_of_month: Int, month_of_year: Int,
                                  separation_count: Int, transaction: Transaction, type: Int) {
            
        }
        
        private func getMatchingTransaction(fk_id: Int64, arr: [Transaction]) -> Transaction? {
            for item in arr {
                if item.id == fk_id {
                    return item
                }
            }
            return nil
        }
        
        private func getDateInterval(last_opened: String) {
            let current_date = dateFormatter.string(from: Date())
            
            
        }

        
        //MARK: - Life Cycle
        init(expenses: [Expense], incomes: [Income], repeats: [Repeat]) {
            self.expenses = expenses
            self.incomes = incomes
            self.repeats = repeats
            self.groupedExpenses = separateIntoSections(transactions: self.expenses)
            self.groupedIncomes = separateIntoSections(transactions: self.incomes)
            self.groupedTitleContent = getTitleContent()
        }
    }
}

extension Date {
    static func dates(fromDate: Date, toDate: Date) -> [String] {
        var dates: [String] = []
        
        return dates
    }
}
