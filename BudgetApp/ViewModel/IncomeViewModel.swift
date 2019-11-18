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
        private var incomes: [Income] {
            didSet {
                incomes.sort(by: {$0.date > $1.date})
            }
        }
        
        var numberOfIncomes: Int {
            return incomes.count
        }
        
        private func income(at index: Int ) -> Income {
            return incomes[index]
        }
        
        func amount(at index: Int) -> String {
            let amount = Double(incomes[index].amount / 100)
            return "$" + String(format: "%.2f", amount)
        }
        
        func description(at index: Int) -> String {
            return income(at: index).description
        }
        
        func dateText(at index: Int) -> String {
            return income(at: index).date
        }
        
        func addNewIncomeViewModel() -> AddNewIncomeViewController.ViewModel {
            let income = Income()
            let addViewModel = AddNewIncomeViewController.ViewModel(income: income)
            return addViewModel
        }
        
// MARK: - Life Cycle
        init(incomes: [Income]) {
            self.incomes = incomes
            self.incomes.sort(by: {$0.date > $1.date})
        }
    }
}
