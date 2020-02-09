//
//  IncomeViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/10/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation
import UIKit

class IncomeViewController: UIViewController {
    
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
        self.title = "Income"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: .addButtonTapped)
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
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        let addViewModel = viewModel.addNewIncomeViewModel()
        let addVC = AddNewIncomeViewController(viewModel: addViewModel, edit: false)
        addVC.addNewIncomeViewControllerDelegate = self
        let nav = UINavigationController(rootViewController: addVC)
        navigationController?.present(nav, animated: true)
    }
}


// MARK: - Selectors
extension Selector {
    fileprivate static let addButtonTapped = #selector(IncomeViewController.addButtonTapped(sender:))
}

// MARK: - UITableViewDataSource
extension IncomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(at: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionCount(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TransactionTableViewCell.self)) as! TransactionTableViewCell
        cell.textLabel?.text = viewModel.description(at: indexPath)
        cell.detailTextLabel?.text = viewModel.dateText(at: indexPath)
        cell.customLabel?.text = viewModel.amount(at: indexPath)
        cell.editingAccessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteIncome(at: indexPath)
            tableView.beginUpdates()
            if (viewModel.sectionCount(at: indexPath.section) > 1) {
                print("here")
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            else {
                print("here1")
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
            tableView.endUpdates()
        }
    }
    
    
    
    
    
}

// MARK: - UITableViewDelegate
extension IncomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewModel = viewModel.editIncomeViewModel(at: indexPath)
        let  editVC = AddNewIncomeViewController(viewModel: editViewModel, edit: true)
        editVC.addNewIncomeViewControllerDelegate = self
        let nav = UINavigationController(rootViewController: editVC)
        navigationController?.present(nav, animated: true)
    }
}

// MARK: - AddNewIncomeViewControllerDelegate
extension IncomeViewController: AddNewIncomeViewControllerDelegate {
    func didAddIncome(_ income: Income) {
        viewModel.addIncome(income: income)
        tableView.reloadData()
    }
    
    func didUpdateIncome(_ income: Income) {
        viewModel.updateIncome(income: income)
        tableView.reloadData()
    }
}

