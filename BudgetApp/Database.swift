//
//  Database.swift
//  BudgetApp
//
//  Created by joe rho on 10/25/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation
import SQLite

class Database {
    
    static let instance = Database()
    private let db: Connection?
    
    //Income and Expense columns and data
    private let incomeTable = Table("income")
    private let expenseTable = Table("expense")
    private let id = Expression<Int64>("id")
    private let description = Expression<String>("description")
    private let amount = Expression<Int>("amount")
    private let date = Expression<String>("date")
    private let category = Expression<String>("category")
    private let repeats = Expression<String>("repeats")
    
    // Repeat table columns and data
    private let repeatTable = Table("repeat")
    private let type = Expression<Int>("type") // 0 if expense 1 if income
    private let fk_id = Expression<Int64>("fk_id") // used to locate entries in either tables
    private let max_num_of_occurrences = Expression<Int>("max_num_of_occurrences")
    private let recurring_type = Expression<Int>("recurring_type")
    private let separation_count = Expression<Int>("separation_count")
    private let day_of_week = Expression<Int>("day_of_the_week")
    private let week_of_month = Expression<Int>("week_of_the_month")
    private let month_of_year = Expression<Int>("month_of_year")
    
    
    
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("database").appendingPathExtension("sqlite3")
            db = try Connection(fileUrl.path)
        }
        catch {
            db = nil
            print(error)
        }
        createIncomeTable()
        createExpenseTable()
    }
    
    // MARK: - Create
    func createExpenseTable() {
        do {
            if !tableExists(tableName: "expense") {
                print("creating table 'expense'")
                //let expense = Table("expense")
                try db?.run(expenseTable.create { t in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(description)
                    t.column(amount)
                    t.column(date)
                    t.column(category)
                    t.column(repeats)
                })
            }
        }
        catch {
            print(error)
        }
    }
    
    func createIncomeTable() {
        do {
            if !tableExists(tableName: "income") {
                print("creating table 'income'")
                //let income = Table("income")
                try db?.run(incomeTable.create { t in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(description)
                    t.column(amount)
                    t.column(date)
                })
            }
            
        }
        catch {
            print(error)
        }
    }
    
    func createRepeatsTable() {
        do {
            if !tableExists(tableName: "repeat") {
                print("creating table 'repeat'")
            }
            try db?.run(repeatTable.create { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(type)
                t.column(fk_id)
                t.column(max_num_of_occurrences)
                t.column(recurring_type)
                t.column(separation_count)
                t.column(day_of_week)
                t.column(week_of_month)
                t.column(month_of_year)
            })
        }
        catch {
            print(error)
        }
    }
    
    func tableExists(tableName: String) -> Bool {
        do {
            return try db?.scalar(
                "SELECT EXISTS (SELECT * FROM sqlite_master WHERE type = 'table' AND name = ?)",
                tableName
            ) as! Int64 > 0
        }
        catch {
            print(error)
        }
        
        //should not reach
        return false
    }
    
    
    // MARK: - Expense
    func addExpense(expense: Expense) -> Int64 {
        var returnId: Int64 = -1

        do {
            let insert = expenseTable.insert(
                description <- expense.description,
                amount <- expense.amount,
                date <- expense.date,
                category <- expense.category.rawValue,
                repeats <- expense.repeats.rawValue
                )
            returnId = try db!.run(insert)
            print("successfully added expense")
            
        }
        catch {
            print(error)
        }
        return returnId
    }
    
    func updateExpense(expense: Expense) {
        do {
            let item = expenseTable.filter(id == expense.id!)
            let update = item.update(
                [
                    description <- expense.description,
                    amount <- expense.amount,
                    date <- expense.date,
                    category <- expense.category.rawValue,
                    repeats <- expense.repeats.rawValue
                ])
            try db!.run(update)
        }
        catch {
            print(error)
        }
    }
    
    func deleteExpense(expense: Expense) {
        do {
            let item = expenseTable.filter(id == expense.id!)
            let delete = item.delete()
            try db!.run(delete)
            print("deleted item ", expense.id!)
        }
        catch {
            print(error)
        }
    }
    
    func getExpenses() -> [Expense] {
        var expenses = [Expense]()
        
        do {
            for expense in try db!.prepare(expenseTable) {
                expenses.append(Expense(
                    id: expense[id],
                    description: expense[description],
                    date: expense[date],
                    amount: expense[amount],
                    category: expense[category],
                    repeats: expense[repeats]
                ))
            }
        }
        catch {
            print(error)
        }
        
        return expenses
    }
    
    // MARK: - Income
    
    // This function returns the ID (primary key) of the newly added entry.
    // Returns -1 if there is an error.
    func addIncome(incomeModel: Income) -> Int64 {
        var returnId: Int64 = -1
        
        do {
            let insert = incomeTable.insert(
                description <- incomeModel.description,
                amount <- incomeModel.amount,
                date <- incomeModel.date
            )
            returnId = try db!.run(insert)
            print("successfully added income")
        }
        catch {
            print(error)
        }
        return returnId
        
    }
    
    func updateIncome(incomeModel: Income) {
        do {
            let item = incomeTable.filter(id == incomeModel.id!)
            let update = item.update(
                [
                    description <- incomeModel.description,
                    amount <- incomeModel.amount,
                    date <- incomeModel.date
                ])
            try db!.run(update)
        }
        catch {
            print(error)
        }
    }
    
    func deleteIncome(incomeModel: Income) {
        do {
            let item = incomeTable.filter(id == incomeModel.id!)
            let delete = item.delete()
            try db!.run(delete)
            print("deleted item ", incomeModel.id!)
        }
        catch {
            print(error)
        }
    }
    
    func getIncomes() -> [Income] {
        var incomes = [Income]()
        
        do {
            for income in try db!.prepare(incomeTable) {
                incomes.append(Income(
                    id: income[id],
                    description: income[description],
                    date: income[date],
                    amount: income[amount]
                ))
            }
        }
        catch {
            print(error)
        }
        
        return incomes
    }
    
    // MARK: - Repeat
    
    func addRepeat(repeatModel: Repeat) -> Int64 {
        var returnId: Int64 = -1
        
        do{
            let insert = repeatTable.insert(
                type <- repeatModel.type,
                fk_id <- repeatModel.fk_id,
                max_num_of_occurrences <- repeatModel.max_num_of_occurrences,
                recurring_type <- repeatModel.recurring_type,
                separation_count <- repeatModel.separation_count,
                day_of_week <- repeatModel.day_of_week,
                week_of_month <- repeatModel.week_of_month,
                month_of_year <- repeatModel.month_of_year
                )
            returnId = try db!.run(insert)
            print("successfully added expense")
        }
        catch {
            print(error)
        }
        return returnId
    }
    
    func updateRepeat(repeatModel: Repeat) {
        do {
            let item = repeatTable.filter(id == repeatModel.id!)
            let update = item.update(
                [
                    type <- repeatModel.type,
                    max_num_of_occurrences <- repeatModel.max_num_of_occurrences,
                    recurring_type <- repeatModel.recurring_type,
                    separation_count <- repeatModel.separation_count,
                    day_of_week <- repeatModel.day_of_week,
                    week_of_month <- repeatModel.week_of_month,
                    month_of_year <- repeatModel.month_of_year
                ])
            try db!.run(update)
        }
        catch {
            print(error)
        }
    }
    
    func deleteRepeat(repeatModel: Repeat) {
        do {
            let item = repeatTable.filter(id == repeatModel.id!)
            let delete = item.delete()
            try db!.run(delete)
            print("deleted item (repeat table) ", repeatModel.id!)
        }
        catch {
            print(error)
        }
    }
    
    func getRepeats() -> [Repeat] {
        var repeats = [Repeat]()
        
        do {
            for repeatModel in try db!.prepare(repeatTable) {
                repeats.append(Repeat(
                    id: repeatModel[id],
                    type: repeatModel[type],
                    fk_id: repeatModel[fk_id],
                    max_num_of_occurrences: repeatModel[max_num_of_occurrences],
                    recurring_type: repeatModel[recurring_type],
                    separation_count: repeatModel[separation_count],
                    day_of_week: repeatModel[day_of_week],
                    week_of_month: repeatModel[week_of_month],
                    month_of_year: repeatModel[month_of_year]
                ))
            }
        }
        catch {
            print(error)
        }
        return repeats
    }

    
}
