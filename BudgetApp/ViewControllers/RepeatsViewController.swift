//
//  RepeatsViewController.swift
//  BudgetApp
//
//  Created by joe rho on 7/21/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation
import UIKit

class RepeatsViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.register(RepeatsTableViewCell.self, forCellReuseIdentifier: String(describing: RepeatsTableViewCell.self))
        tbl.dataSource = self
        tbl.delegate = self
        tbl.tableFooterView = UIView()
        return tbl
    }()
    
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initializeTableView()
        initialize()
    }
    
    private func initializeTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsSelection = false
    }
    
    private func initialize() {
        self.title = "Repeat"
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        print(navigationController == nil)
    }
}

extension RepeatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepeats
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepeatsTableViewCell.self)) as! RepeatsTableViewCell
        cell.textLabel?.text = viewModel.description(at: indexPath)
        cell.detailTextLabel?.text = viewModel.repeat_type(at: indexPath)
        cell.amount.text = viewModel.amount(at: indexPath)
        cell.frequency .text = viewModel.frequency(at: indexPath)
        
        return cell
    }
}

extension RepeatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // present a controller ?
    }
}
