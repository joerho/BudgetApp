//
//  AppDelegate.swift
//  BudgetApp
//
//  Created by joe rho on 10/7/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit
import SQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var database: Connection!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupDatabase()
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = TabBarController() //UINavigationController(rootViewController: TabBarController())
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func setupDatabase() {
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

