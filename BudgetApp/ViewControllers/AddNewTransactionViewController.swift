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
    
    static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MMM d yyyy"
      return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupForm()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupForm() {
        form
        +++ Section()
        <<< DateTimeRow() {
          $0.dateFormatter = type(of: self).dateFormatter //1
          $0.title = "Date" //2
          //$0.value = viewModel.dueDate //3
          $0.minimumDate = Date() //4
          $0.onChange { [unowned self] row in //5
            if let date = row.value {
//              self.viewModel.dueDate = date
            }
          }
        }
            
        +++ Section()
        <<< TextRow() {
          $0.title = "Description"
          $0.placeholder = "e.g. Pick up my laundry"
          $0.value = ""
          $0.onChange { [unowned self] row in
            //self.viewModel.title = row.value
          }
          $0.add(rule: RuleRequired()) //1
          $0.validationOptions = .validatesOnChange //2
          $0.cellUpdate { (cell, row) in //3
            if !row.isValid {
              cell.titleLabel?.textColor = .red
            }
          }
        }
        
        +++ Section()
        <<< TextRow() {
          $0.title = "Amount"
          $0.placeholder = "e.g. Pick up my laundry"
          $0.value = ""
          $0.onChange { [unowned self] row in
            //self.viewModel.title = row.value
          }
          $0.add(rule: RuleRequired()) //1
          $0.validationOptions = .validatesOnChange //2
          $0.cellUpdate { (cell, row) in //3
            if !row.isValid {
              cell.titleLabel?.textColor = .red
            }
          }
        }
        
        
    }
        
    
    private func setupNavBar() {
        self.title = "Add New"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closeView))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeView))
    }
    
    @objc fileprivate func closeView() {
        dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
