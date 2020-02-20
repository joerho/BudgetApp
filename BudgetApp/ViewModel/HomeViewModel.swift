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
        var expenses: [Expense]
        var incomes: [Income]
        
        func getCurrentMonthlyExpense() -> Double {
            return 0.0
        }
        
        func getCurrentMonthlyIncome() -> Double {
            return 0.0
        }
        
        //MARK: - Life Cycle
        init(expenses: [Expense], incomes: [Income]) {
            self.expenses = expenses
            self.incomes = incomes
        }
    }
}
