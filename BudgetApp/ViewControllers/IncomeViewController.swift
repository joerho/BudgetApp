//
//  IncomeViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/10/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    
// MARK: - Life Cycle
    convenience init() {
        self.init()
        initialize()
    }
    
    private func initialize() {
        self.title = "Income"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: .addButtonTapped)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
        
    
    
// MARK: - Actions
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        present(AddNewTransactionViewController(), animated: true, completion: nil)
    }
}


// MARK: - Selectors
extension Selector {
    fileprivate static let addButtonTapped = #selector(IncomeViewController.addButtonTapped(sender:))
}


