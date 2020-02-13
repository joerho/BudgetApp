//
//  HomeViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/10/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel : ViewModel!
    
    // MARK: -Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        self.title = "Home"
    }
    
}
