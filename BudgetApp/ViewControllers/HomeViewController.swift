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
    
    let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    let horizontalStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }()
    
    let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
        
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cyan
        return v
    }()
    
    let label1: CustomView = {
        let label = CustomView()
        label.height = 1.0
        label.backgroundColor = .red
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: CustomView = {
        let label = CustomView()
        label.height = 1.0
        label.backgroundColor = .green
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3: CustomView = {
        let label = CustomView()
        label.height = 2.0
        label.backgroundColor = .blue
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label4: CustomView = {
        let label = CustomView()
        label.height = 2.0
        label.backgroundColor = .cyan
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: -Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        self.title = "Home"
        self.view.addSubview(verticalStackView)

        edgesForExtendedLayout = []

        verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true

        horizontalStackView.addArrangedSubview(label1)
        horizontalStackView.addArrangedSubview(label2)
        bottomStackView.addArrangedSubview(label3)

        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(bottomStackView)
        
        

        

        
//        label1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
//        label1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true
//
//        label2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 400).isActive = true
//        label2.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
//        label2.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16.0).isActive = true
//        label2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
        
    }
    
}
