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
    
    let backgroundView: UIView = {
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = UIColor.systemBackground
        return subView
    }()
    
    let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        //sv.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    let horizontalStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        //sv.spacing = 10
        return sv
    }()
    
    let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        //sv.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
        
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cyan
        return v
    }()
    
    let label1: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.backgroundColor = UIColor.systemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 3
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let label2: CustomView = {
        let label = CustomView()
        label.height = 1.0
        label.backgroundColor = UIColor.systemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let label3: CustomView = {
        let label = CustomView()
        label.height = 3.0
        label.backgroundColor = UIColor.systemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label4: CustomView = {
        let label = CustomView()
        label.height = 1.0
        label.backgroundColor = .cyan
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: -Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initializeBackground()
        initialize()
    }
    
    private func initializeBackground() {
        self.view.addSubview(backgroundView)
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func initialize() {
        self.title = "Home"

        label1.text = "I am a test label"
        backgroundView.addSubview(label1)
        
        //edgesForExtendedLayout = []

//        verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
//        verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
//        verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
//        verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
//
//        horizontalStackView.addArrangedSubview(label1)
//        horizontalStackView.addArrangedSubview(label2)
//        bottomStackView.addArrangedSubview(label3)
//
//        verticalStackView.addArrangedSubview(horizontalStackView)
//        verticalStackView.addArrangedSubview(bottomStackView)

        

        
    }
    
}
