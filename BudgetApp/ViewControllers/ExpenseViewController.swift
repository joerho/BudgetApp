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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Expense"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    @objc fileprivate func addButtonTapped(sender: UIBarButtonItem) {
        present(UINavigationController( rootViewController: AddNewTransactionViewController()), animated: true, completion: nil)
    }
    
}
