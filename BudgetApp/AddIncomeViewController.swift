//
//  AddIncomeViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/9/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation
import UIKit

class AddIncomeViewController: UIViewController {
    @IBOutlet weak var CloseButton: UIBarButtonItem!
    
    
    @IBAction func CloseButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
