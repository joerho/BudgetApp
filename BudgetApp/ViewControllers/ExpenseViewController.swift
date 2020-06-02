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
    
    lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.register(TransactionTableViewCell.self, forCellReuseIdentifier: String(describing: TransactionTableViewCell.self))
        tbl.dataSource = self
        tbl.delegate = self
        tbl.tableFooterView = UIView()
        return tbl
    }()
    
    // MARK: - Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsSelection = false
        self.title = "Expense"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: .addButtonTapped)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        print(navigationController == nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(!isEditing, animated: true)
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // MARK: - Actions
    @objc fileprivate func addButtonTapped(sender: UIBarButtonItem) {
        let addViewModel = viewModel.addNewExpenseViewModel()
        let addVC = AddNewExpenseViewController(viewModel: addViewModel, edit: false)
        let nav = UINavigationController(rootViewController: addVC)
        addVC.addNewExpenseViewControllerDelegate = self
        navigationController?.present(nav, animated: true)
    }
    
}

// MARK: - Selectors
extension Selector {
    fileprivate static let addButtonTapped = #selector(ExpenseViewController.addButtonTapped(sender:))
}

// MARK: - UITableViewDataSource
extension ExpenseViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(at: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionCount(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TransactionTableViewCell.self)) as! TransactionTableViewCell
        cell.textLabel?.text = viewModel.description(at: indexPath)
        cell.detailTextLabel?.text = viewModel.dateText(at: indexPath)
        cell.customLabel.text = viewModel.amount(at: indexPath)
        cell.editingAccessoryType = .disclosureIndicator
        
        return cell
    }
    
    // Disables swipe to delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if (viewModel.sectionCount(at: indexPath.section) > 1) {
                viewModel.deleteExpense(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            else {
                viewModel.deleteExpense(at: indexPath)
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
            tableView.endUpdates()
        }
    }
}


// MARK: - UITableViewDelegate
extension ExpenseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewModel = viewModel.editViewModel(at: indexPath)
        let editVC = AddNewExpenseViewController(viewModel: editViewModel, edit: true)
        editVC.addNewExpenseViewControllerDelegate = self
        let nav = UINavigationController(rootViewController: editVC)
        navigationController?.present(nav, animated: true)
    }
    
}

// MARK: - AddNewExpenseViewControllerDelegate
extension ExpenseViewController: AddNewExpenseViewControllerDelegate {
    func didAddExpense(_ expense: Expense) {
        viewModel.addExpense(expense: expense)
        tableView.reloadData()
    }
    
    func didUpdateExpense(_ expense: Expense) {
        viewModel.updateExpense(expense: expense)
        viewModel.setGroupedTransactions()
        tableView.reloadData()
    }
}
