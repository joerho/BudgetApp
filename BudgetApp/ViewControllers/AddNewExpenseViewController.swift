//
//  AddNewTransactionViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/15/19.
//  Copyright © 2019 joe rho. All rights reserved.
//
import Eureka
import UIKit

protocol AddNewExpenseViewControllerDelegate {
    func didAddExpense(_ transaction: Expense)
    func didUpdateExpense(_ transaction: Expense)
}

class AddNewExpenseViewController: FormViewController {
    
    var addNewExpenseViewControllerDelegate: AddNewExpenseViewControllerDelegate?
    var viewModel: ViewModel!
    var edit: Bool!
    
    
    // MARK: - Life Cycle
    convenience init(viewModel: ViewModel, edit: Bool) {
        self.init()
        self.viewModel = viewModel
        self.edit = edit
        edit ? initializeEdit() : initializeAdd()
        setupForm()
    }
    
    
    private func setupForm() {
        
        form
        +++ Section("Transaction")
        <<< DateRow() {
            $0.dateFormatter = Formatter.mmddyyyy
            $0.title = "Date"
            $0.value = Formatter.mmddyyyy.date(from: viewModel.date)
            $0.onChange { [unowned self] row in
                if let date = row.value {
                    self.viewModel.date = Formatter.mmddyyyy.string(from: date)
                }
            }
        }
            
        <<< TextRow() {
            $0.title = "Description"
            $0.placeholder = "e.g. Dinner with GF"
            $0.value = viewModel.description
            $0.onChange { [unowned self] row in
                if let value = row.value {
                    self.viewModel.description = value
                }
            }
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { (cell, row) in //3
                if !row.isValid || row.value == "" {
                    cell.titleLabel?.textColor = .red
                }
            }
            $0.onRowValidationChanged { (cell, row) in
                if self.form.isClean() {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
                else {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        }
        
        <<< DecimalRow() {
            $0.useFormatterDuringInput = true
            $0.title = "Amount"
            $0.value = edit ? Double(viewModel.amount)/100 : nil
            $0.placeholder = "e.g $420.69"
            $0.formatter = viewModel.numberFormatter
            $0.onChange { [unowned self] row in
                if let value = row.value {
                    self.viewModel.amount = Int(value * 100)
                }
            }
            $0.add(rule: RuleRequired())
            $0.add(rule: RuleGreaterThan(min: 0))
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            $0.onRowValidationChanged { (cell, row) in
                if self.form.isClean() {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
                else {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        }
        
        <<< PushRow<String>() { //1
            $0.title = "Repeats" //2
            $0.value = viewModel.repeats //3
            $0.options = viewModel.repeatOptions //4
            $0.onChange { [unowned self] row in //5
              if let value = row.value {
                self.viewModel.repeats = value
              }
            }
        }
        
        <<< PushRow<String>() {
            $0.title = "Category"
            $0.value = viewModel.category
            $0.options = viewModel.categoryOptions
            $0.onChange { [unowned self] row in
                if let value = row.value {
                    self.viewModel.category = value
                }
            }
        }
        
        form.validate()
    }

    
    private func initializeAdd() {
        self.title = "Add New Transaction"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: .donePressedAdd)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: .closeView)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func initializeEdit() {
        self.title = "Edit Transaction"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: .donePressedEdit)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: .closeView)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    

    
// MARK: - Actions
    @objc fileprivate func closeView(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc fileprivate func donePressedAdd(sender: UIBarButtonItem) {
        let model = viewModel.getExpense()
        addNewExpenseViewControllerDelegate?.didAddExpense(model)
        dismiss(animated: true)
    }
    
    @objc fileprivate func donePressedEdit(sender: UIBarButtonItem) {
        let model = viewModel.getExpense()
        addNewExpenseViewControllerDelegate?.didUpdateExpense(model)
        dismiss(animated: true)
    }
}

// MARK: - Selector
extension Selector {
    fileprivate static let closeView = #selector(AddNewExpenseViewController.closeView(sender:))
    
    fileprivate static let donePressedAdd = #selector(AddNewExpenseViewController.donePressedAdd(sender:))
    
    fileprivate static let donePressedEdit = #selector(AddNewExpenseViewController.donePressedEdit(sender:))
}

// MARK: - Form
extension Form {

    public func isClean() ->Bool {
        for row in rows {
            if !row.isValid {
                return false
            }
        }
        return true
    }
}
