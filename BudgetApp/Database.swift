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
    private let income = Table("income")
    private let expense = Table("expense")
    private let id = Expression<Int64>("id")
    private let description = Expression<String?>("description")
    private let amount = Expression<Double>("amount")
    private let date = Expression<String>("date")
    private let category = Expression<String?>("category")
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
    
    func createExpenseTable() {
        do {
            
            
            
            if !tableExists(tableName: "expense") {
                print("creating table 'expense'")
                //let expense = Table("expense")
                try db?.run(expense.create { t in
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
                try db?.run(income.create { t in
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
    
    func addExpense(transactionViewModel: AddNewTransactionViewController.ViewModel) {
        do {
            let insert = expense.insert(
                description <- transactionViewModel.description,
                amount <- transactionViewModel.amount.doubleValue,
                date <- transactionViewModel.date,
                category <- transactionViewModel.category,
                repeats <- transactionViewModel.repeats
                )
            try db!.run(insert)
            print("successfully added transaction (expense)")
            
        } catch {
            print(error)
        }
    }
    
    func getExpenses() -> ExpenseViewController.ExpenseViewModel {
        var expenses = [AddNewTransactionViewController.ViewModel]()
        
        
        
        return expenses
    }
    
    
    
}
