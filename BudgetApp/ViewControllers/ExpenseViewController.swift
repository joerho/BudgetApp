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
        let addViewModel = viewModel.addNewTransactionViewModel()
        let addVC = AddNewTransactionViewController(viewModel: addViewModel, edit: false)
        let nav = UINavigationController(rootViewController: addVC)
        addVC.addNewTransactionViewControllerDelegate = self
        navigationController?.present(nav, animated: true)
    }
    
}

// MARK: - Selectors
extension Selector {
    fileprivate static let addButtonTapped = #selector(ExpenseViewController.addButtonTapped(sender:))
}


// MARK: - UITableViewDataSource
extension ExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTransactions
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TransactionTableViewCell.self)) as! TransactionTableViewCell
        cell.textLabel?.text = viewModel.description(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel.dateText(at: indexPath.row)
        cell.customLabel?.text = viewModel.amount(at: indexPath.row)
        cell.editingAccessoryType = .disclosureIndicator
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTransaction(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}


// MARK: - UITableViewDelegate
extension ExpenseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewModel = viewModel.editViewModel(at: indexPath.row)
        let editVC = AddNewTransactionViewController(viewModel: editViewModel, edit: true)
        editVC.addNewTransactionViewControllerDelegate = self
        let nav = UINavigationController(rootViewController: editVC)
        navigationController?.present(nav, animated: true)
    }
}

// MARK: - AddNewTransactionViewControllerDelegate
extension ExpenseViewController: AddNewTransactionViewControllerDelegate {
    func didAddTransaction(_ transaction: Transaction) {
        viewModel.addTransaction(transaction: transaction)
        tableView.reloadData()
    }
    
    // potentially change to index?
    func didUpdateTransaction(_ transaction: Transaction) {
        viewModel.updateTransaction(transaction: transaction)
        tableView.reloadData()
    }
}
