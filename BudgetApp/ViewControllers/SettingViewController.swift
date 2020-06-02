//
//  SettingViewController.swift
//  BudgetApp
//
//  Created by joe rho on 3/26/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tbl.dataSource = self
        tbl.delegate = self
        tbl.isScrollEnabled = true
        tbl.allowsSelection = true
        tbl.tableFooterView = UIView()
        return tbl
    }()
    
    // MARK: - Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.separatorInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        
        self.title = "Setting"
    }
}
// MARK: - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.text = "Test"
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.backgroundColor = .systemGray6
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
