//
//  AddExpenseViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/8/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation
import UIKit

class AddExpenseViewController: UIViewController {
    @IBOutlet weak var CloseButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CloseButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
