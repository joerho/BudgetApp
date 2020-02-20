//
//  TabBarController.swift
//  BudgetApp
//
//  Created by joe rho on 10/9/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit
import SQLite

class TabBarController: UITabBarController{
    
    
    var item1: UIViewController?
    var item2: UIViewController?
    var item3: UIViewController?
    var controllers:[UIViewController] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let expenses = Database.instance.getExpenses()
        let incomes = Database.instance.getIncomes()
        let expenseViewModel = ExpenseViewController.ViewModel(expenses: expenses)
        let incomeViewModel = IncomeViewController.ViewModel(incomes: incomes)
        let homeViewModel = HomeViewController.ViewModel(expenses: expenses, incomes: incomes)
        
        item1 = UINavigationController(rootViewController: ExpenseViewController(viewModel: expenseViewModel))
        item2 = UINavigationController(rootViewController: HomeViewController(viewModel: homeViewModel))
        item3 = UINavigationController(rootViewController: IncomeViewController(viewModel: incomeViewModel))
        
        item1?.tabBarItem = UITabBarItem(title: "expense", image: UIImage(systemName: "chevron.down.square.fill"), tag: 0)
        item2?.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "chart.pie"), tag: 1)
        item3?.tabBarItem = UITabBarItem(title: "income", image: UIImage(systemName: "chevron.up.square.fill"), tag: 2)

        controllers.append(item1!)
        controllers.append(item2!)
        controllers.append(item3!)
        
        //self.selectedIndex = 1
        self.viewControllers = controllers

    }
}
    
