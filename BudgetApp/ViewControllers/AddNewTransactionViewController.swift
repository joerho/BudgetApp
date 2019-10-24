//
//  AddNewTransactionViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/15/19.
//  Copyright © 2019 joe rho. All rights reserved.
//
import Eureka
import UIKit

class AddNewTransactionViewController: FormViewController {
    
    var viewModel: ViewModel!
    
    static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter
    }()
    
    let categorySectionTag: String = "add category section"
    let categoryRowTag: String = "add category row"
    
    static let numberFormatter: CurrencyFormatter = {
        let formatter = CurrencyFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.generatesDecimalNumbers = true
        
        return formatter
    }()
    
    
    // MARK: - Life Cycle
    
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    private func setupForm() {
        form
        +++ Section()
        <<< DateRow() {
            $0.dateFormatter = type(of: self).dateFormatter
            $0.title = "Date"
            $0.value = viewModel.date
            $0.onChange { [unowned self] row in
                if let date = row.value {
                    self.viewModel.date = date
                }
            }
        }
            
        //+++ Section()
        <<< TextRow() {
            $0.title = "Description"
            $0.placeholder = "e.g. Pho with Brandon"
            $0.value = viewModel.description
            $0.onChange { [unowned self] row in
                self.viewModel.description = row.value
            }
        }
        
        //+++ Section()
        <<< DecimalRow() {
            $0.useFormatterDuringInput = true
            $0.title = "Amount"
            $0.value = viewModel.amount.doubleValue
            $0.placeholder = "e.g $420.69"
            $0.formatter = type(of: self).numberFormatter
            
            $0.onChange { [unowned self] row in
                self.viewModel.amount = NSDecimalNumber(string: String(row.value!))
                print(self.viewModel.amount)
                
            }
            
            $0.add(rule: RuleRequired()) //1
            $0.validationOptions = .validatesOnChange //2
            $0.cellUpdate { (cell, row) in //3
                if !row.isValid {
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
        
        +++ Section("Category") {
            $0.tag = self.categorySectionTag
            $0.hidden = (self.viewModel.category != nil) ? false : true
        }

        <<< TransactionCategoryRow() { row in
            row.tag = self.categoryRowTag
            row.value = self.viewModel.category
            row.options = self.viewModel.categoryOptions

            row.onChange { [unowned self] row in
                self.viewModel.category = row.value
            }
        }
    }
        
    
    private func initialize() {
        self.title = "Add New"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: .donePressed)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: .closeView)
    }
    

    
    // MARK: - Actions
    @objc fileprivate func closeView(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc fileprivate func donePressed(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }


}

class CurrencyFormatter: NumberFormatter, FormatterProtocol {
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, range rangep: UnsafeMutablePointer<NSRange>?) throws {
            guard obj != nil else { return }
            var str = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            if !string.isEmpty, numberStyle == .currency && !string.contains(currencySymbol) {
                // Check if the currency symbol is at the last index
                if let formattedNumber = self.string(from: 1), String(formattedNumber[formattedNumber.index(before: formattedNumber.endIndex)...]) == currencySymbol {
                    // This means the user has deleted the currency symbol. We cut the last number and then add the symbol automatically
                    str = String(str[..<str.index(before: str.endIndex)])

                }
            }
            obj?.pointee = NSNumber(value: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
        }

        func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
            return textInput.position(from: position, offset:((newValue?.count ?? 0) - (oldValue?.count ?? 0))) ?? position
        }
}



// MARK: - Selector
extension Selector {
    fileprivate static let closeView = #selector(AddNewTransactionViewController.closeView(sender:))
    
    fileprivate static let donePressed = #selector(AddNewTransactionViewController.donePressed(sender:))
}



