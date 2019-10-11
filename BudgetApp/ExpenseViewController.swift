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
        self.title = "expense"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        present(AddNewViewController(), animated: true, completion: nil)
    }
    
}
