//
//  ViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/7/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit
import SQLite


class ViewController: UIViewController {
    var database: Connection!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // create local file for database if it does not already exist
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("database").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            
            let id = Expression<Int64>("id")
            let description = Expression<String?>("description")
            let amount = Expression<Double>("amount")
            let date = Expression<String>("date")
            
            
            if !tableExists(tableName: "income") {
                print("creating table 'income'")
                let income = Table("income")
                try database.run(income.create { t in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(description, defaultValue: "misc.")
                    t.column(amount)
                    t.column(date)
                })
            }
            
            if !tableExists(tableName: "expense") {
                print("creating table 'expense'")
                let expense = Table("expense")
                try database.run(expense.create { t in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(description, defaultValue: "misc.")
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
            return try database.scalar(
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


