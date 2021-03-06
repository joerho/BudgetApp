//
//  IncomeViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 11/17/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation

extension IncomeViewController {
    
    class ViewModel : BaseViewModel {
        
        func editIncomeViewModel(at indexPath: IndexPath) -> AddNewIncomeViewController.ViewModel {
            let incomeModel = section(at: indexPath.section).transactions[indexPath.row]
            let editViewModel = AddNewIncomeViewController.ViewModel(income: incomeModel as! Income)
            return editViewModel
        }
        
        func addNewIncomeViewModel() -> AddNewIncomeViewController.ViewModel {
            let income = Income()
            let addViewModel = AddNewIncomeViewController.ViewModel(income: income)
            return addViewModel
        }
        
        // MARK: - Database Interaction Methods
        func deleteIncome(at indexPath: IndexPath) {
            let income = section(at: indexPath.section).transactions[indexPath.row]
            Database.instance.deleteIncome(incomeModel: income as! Income)
            if let index = self.transactions.firstIndex(of: income) {
                self.transactions.remove(at: index)
            }
            self.groupedTransactions = separateIntoSections(transactions: self.transactions)
        }
        
        func updateIncome(income: Income) {
            Database.instance.updateIncome(incomeModel: income)
        }
        
        func addIncome(income: Income) {
            // Set the id of the Income instance.
            income.id = Database.instance.addIncome(incomeModel: income)
            transactions.append(income)
            self.groupedTransactions = separateIntoSections(transactions: self.transactions)
        }
        
        // MARK: - Life Cycle
        init(incomes: [Income]) {
            super.init(transactions: incomes)
        }
    }
}
