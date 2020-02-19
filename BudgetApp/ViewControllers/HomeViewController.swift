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
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    let horizontalStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 20
        sv.layoutMargins = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        sv.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
        
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cyan
        return v
    }()
    
    let label1: UIView = {
        let label = UIView()
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.backgroundColor = .red
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UIView = {
        let label = UIView()
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.backgroundColor = .green
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3: UIView = {
        let label = UIView()
        label.backgroundColor = .blue
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label4: UIView = {
        let label = UIView()
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

        verticalStackView.addArrangedSubview(horizontalStackView)

        bottomStackView.addArrangedSubview(label3)
        bottomStackView.addArrangedSubview(label4)

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
