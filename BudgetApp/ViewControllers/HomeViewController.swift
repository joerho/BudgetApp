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

    lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.register(HomeViewCell.self, forCellReuseIdentifier: String(describing: HomeViewCell.self))
        tbl.dataSource = self
        tbl.delegate = self
        tbl.tableFooterView = UIView()
        return tbl
    }()
    
    // MARK: -Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
        
        self.title = viewModel.getCurrentMonthYear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let expenses = Database.instance.getExpenses()
        let incomes = Database.instance.getIncomes()
        self.viewModel = .init(expenses: expenses, incomes: incomes)
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupedTitleContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewCell.self)) as! HomeViewCell
        cell.title.text = viewModel.groupedTitleContent[indexPath.row].title
        cell.content.text = viewModel.groupedTitleContent[indexPath.row].content
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

