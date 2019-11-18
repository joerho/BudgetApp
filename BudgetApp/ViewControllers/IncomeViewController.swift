//
//  IncomeViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/10/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    lazy var tableView: UITableView = {
        let tbl = UITableView()
        return tbl
    }()
    
// MARK: - Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        self.title = "Income"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: .addButtonTapped)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
        
    
    
// MARK: - Actions
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        let addViewModel = viewModel.addNewIncomeViewModel()
        let addVC = AddNewIncomeViewController(viewModel: addViewModel, edit: false)
        let nav = UINavigationController(rootViewController: addVC)
        navigationController?.present(nav, animated: true)
    }
}


// MARK: - Selectors
extension Selector {
    fileprivate static let addButtonTapped = #selector(IncomeViewController.addButtonTapped(sender:))
}


