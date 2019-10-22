//
//  ExpenseViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/8/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation
import UIKit

class ExpenseViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    // MARK: - Life Cycle
    
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Expense"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: .addButtonTapped)
    }
    
    
    // MARK: - Actions
    @objc fileprivate func addButtonTapped(sender: UIBarButtonItem) {
        let addViewModel = viewModel.addNewTransactionViewModel()
        let addVC = UINavigationController(rootViewController: AddNewTransactionViewController(viewModel: addViewModel))
        navigationController?.present(addVC, animated: true)
    }
    
}

// MARK: - Selectors
extension Selector {
    fileprivate static let addButtonTapped = #selector(ExpenseViewController.addButtonTapped(sender:))
}
