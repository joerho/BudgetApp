//
//  AddNewTransactionViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/15/19.
//  Copyright © 2019 joe rho. All rights reserved.
//
import Eureka
import UIKit

protocol AddNewTransactionViewControllerDelegate {
    func didAddTransaction(_ transaction: Transaction)
    func didUpdateTransaction()
}


class AddNewTransactionViewController: FormViewController {
    
    var addNewTransactionViewControllerDelegate: AddNewTransactionViewControllerDelegate?
    var viewModel: ViewModel!
    var edit: Bool!
    
    
    private var validateArr = [Bool]() {
        didSet {
            if !self.validateArr.contains(false) {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    
    // MARK: - Life Cycle
    
    convenience init(viewModel: ViewModel, edit: Bool) {
        self.init()
        self.viewModel = viewModel
        self.edit = edit
        
        edit ? initializeEdit() : initializeAdd()
        setupForm()
        print("here")
    }
    
    
    private func setupForm() {
        
        form
        +++ Section("Transaction")
        <<< DateRow() {
            $0.dateFormatter = viewModel.dateFormatter
            $0.title = "Date"
            $0.value = viewModel.dateFormatter.date(from: viewModel.date)
            $0.onChange { [unowned self] row in
                if let date = row.value {
                    self.viewModel.date = self.viewModel.dateFormatter.string(from: date)
                    print(self.viewModel.date)
                }
            }
        }
            
        //+++ Section()
        <<< TextRow() {
            $0.title = "Description"
            $0.placeholder = "e.g. Pho with Brandon"
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
        }
        
        //+++ Section()
        <<< DecimalRow() {
            $0.useFormatterDuringInput = true
            $0.title = "Amount"
            $0.value = Double(viewModel.amount)/100
            $0.placeholder = "e.g $420.69"
            $0.formatter = viewModel.numberFormatter
            $0.onChange { [unowned self] row in
                if let value = row.value {
                    self.viewModel.amount = Int(value * 100)
                    //print(self.viewModel.amount)
                }
            }
            $0.add(rule: RuleRequired()) //1
            $0.validationOptions = .validatesOnChange //2
            $0.cellUpdate { (cell, row) in //3
                if !row.isValid || row.value == 0 {
                    cell.titleLabel?.textColor = .red
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
        for row in form.allRows {
            //validateArr.append(row.isValid)
            row.isValid
        }
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
        let model = viewModel.getTransaction()
        addNewTransactionViewControllerDelegate?.didAddTransaction(model)
        Database.instance.addExpense(transactionViewModel: viewModel)
        dismiss(animated: true)
    }
    
    @objc fileprivate func donePressedEdit(sender: UIBarButtonItem) {
        addNewTransactionViewControllerDelegate?.didUpdateTransaction()
        Database.instance.updateExpense(transactionViewModel: viewModel)
        dismiss(animated: true)
    }


}




// MARK: - Selector
extension Selector {
    fileprivate static let closeView = #selector(AddNewTransactionViewController.closeView(sender:))
    
    fileprivate static let donePressedAdd = #selector(AddNewTransactionViewController.donePressedAdd(sender:))
    
    fileprivate static let donePressedEdit = #selector(AddNewTransactionViewController.donePressedEdit(sender:))

}
