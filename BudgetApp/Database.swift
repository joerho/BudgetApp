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
            let id = Expression<Int64>("id")
            let description = Expression<String?>("description")
            let amount = Expression<Double>("amount")
            let date = Expression<String>("date")
            let category = Expression<String?>("category")
            let repeats = Expression<String>("repeats")
            
            
            if !tableExists(tableName: "expense") {
                print("creating table 'expense'")
                let expense = Table("expense")
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
            let id = Expression<Int64>("id")
            let description = Expression<String?>("description")
            let amount = Expression<Double>("amount")
            let date = Expression<String>("date")
            
            if !tableExists(tableName: "income") {
                print("creating table 'income'")
                let income = Table("income")
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
    
    
}
