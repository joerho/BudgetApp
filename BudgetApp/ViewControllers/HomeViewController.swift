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
        tbl.isScrollEnabled = false
        tbl.allowsSelection = false
        return tbl
    }()
    
    // MARK: - Life Cycle
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        initializeTableView()
        initialize()
        createObserver()
        createTestButton()
    }
    
    private func createTestButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Time Travel", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    private func initializeTableView() {
        // Initialize UITableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    private func initialize() {
        // Initialize title with current Month and Year
        self.title = viewModel.getCurrentMonthYear()
        
        // Initialize gear button on navigation bar
        let settingsButton = UIBarButtonItem(title: NSString(string: "\u{2699}\u{0000FE0E}") as String, style: .plain, target: self, action: .gearButtonTapped)
        let font = UIFont.systemFont(ofSize: 30) // adjust the size as required
        let attributes = [NSAttributedString.Key.font : font]
        settingsButton.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem = settingsButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let expenses = Database.instance.getExpenses()
        let incomes = Database.instance.getIncomes()
        let repeats = Database.instance.getRepeats()
        self.viewModel = .init(expenses: expenses, incomes: incomes, repeats: repeats)
        tableView.reloadData()
    }
    
    // Does not catch the notification
    // Possibly move elsewhere
    func createObserver() {
        guard let last_opened_date = UserDefaults.standard.object(forKey: "lastOpened") as? Date else {
            return
        }
        print(last_opened_date)
        NotificationCenter.default.addObserver(self, selector: .handleRepeat, name: NSNotification.Name.NSCalendarDayChanged, object: nil)
    }
    
    // MARK: - Actions
    @objc fileprivate func gearButtonTapped(sender: UIBarButtonItem) {
        let repeatList = viewModel.getRepeats()
        let expenseList = viewModel.getExpenses()
        let incomeList = viewModel.getIncomes()
        let viewModel = RepeatsViewController.ViewModel(repeats: repeatList, expenses: expenseList, incomes: incomeList)
        let newVC = RepeatsViewController(viewModel: viewModel)
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc fileprivate func handleRepeat() {
        viewModel.repeatHandler()
    }
    
    
    //Repeat Tester button action
    //Delete after use
    @objc func buttonAction(sender: UIButton!) {
        NotificationCenter.default.post(name: .NSCalendarDayChanged, object: nil)
    }
}

// MARK: - Selectors
extension Selector {
    fileprivate static let gearButtonTapped = #selector(HomeViewController.gearButtonTapped(sender:))
    fileprivate static let handleRepeat = #selector(HomeViewController.handleRepeat)
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

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

