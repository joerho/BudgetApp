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
    private let incomeTable = Table("income")
    private let expenseTable = Table("expense")
    private let id = Expression<Int64>("id")
    private let description = Expression<String>("description")
    private let amount = Expression<Int>("amount")
    private let date = Expression<String>("date")
    private let category = Expression<String>("category")
    private let repeats = Expression<String>("repeats")
    
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
        } catch {
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
            
        } catch {
            print(error)
        }
    }
    
    func tableExists(tableName: String) -> Bool {
        do {
            return try db?.scalar(
                "SELECT EXISTS (SELECT * FROM sqlite_master WHERE type = 'table' AND name = ?)",
                tableName
            ) as! Int64 > 0
        } catch {
            print(error)
        }
        
        //should not reach
        return false
    }
    
    
// MARK: - Expense
    func addExpense(expense: Expense) {
        do {
            let insert = expenseTable.insert(
                id <- expense.id!,
                description <- expense.description,
                amount <- expense.amount,
                date <- expense.date,
                category <- expense.category.rawValue,
                repeats <- expense.repeats.rawValue
                )
            try db!.run(insert)
            print("successfully added expense (expense)")
            
        } catch {
            print(error)
        }
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
        } catch {
            print(error)
        }
    }
    
    func deleteExpense(expense: Expense) {
        do {
            let item = expenseTable.filter(id == expense.id!)
            let delete = item.delete()
            try db!.run(delete)
            print("deleted item ", expense.id!)
        } catch {
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
            print(expenses)
        } catch {
            print(error)
        }
        
        
        return expenses
    }
    
// MARK: - Income
    func addIncome(incomeModel: Income) {
        do {
            let insert = incomeTable.insert(
                id <- incomeModel.id!,
                description <- incomeModel.description,
                amount <- incomeModel.amount,
                date <- incomeModel.date
            )
            try db!.run(insert)
            print("successfully added income (income)")
            
        } catch {
            print(error)
        }
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
        } catch {
            print(error)
        }
    }
    
    func deleteIncome(incomeModel: Income) {
        do {
            let item = incomeTable.filter(id == incomeModel.id!)
            let delete = item.delete()
            try db!.run(delete)
        } catch {
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
        } catch {
            print(error)
        }
        
        return incomes
    }
    
}
