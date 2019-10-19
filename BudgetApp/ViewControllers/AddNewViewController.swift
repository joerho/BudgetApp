//
//  AddNewViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/10/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation
import UIKit
import LBTATools
import SQLite

class AddNewViewController: LBTAFormController {
    
    
    var tfArray: [UITextField] = []
    var dateFormatter: DateFormatter = DateFormatter()
    var selectedDate: String = ""
    
    let confirmButton = UIButton(title: "Confirm", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: .blue, target: self, action: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "CustomColorForLBTA")
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 66))
        let navItem = UINavigationItem(title: "Add New")
        let rightButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeView))
        
        navItem.rightBarButtonItem = rightButton
        navBar.items = [navItem]
        self.view.addSubview(navBar)
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 10
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        
        setupDatePicker()
        setupTextFields()
    }
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.selectedDate = dateFormatter.string(from: datePicker.date)
        formContainerStackView.addArrangedSubview(datePicker)
        
    }
    
    func setupTextFields() {
        (0...1).forEach {(_) in
            let tf = IndentedTextField(padding: 12, cornerRadius: 5,  backgroundColor: UIColor(named: "TextFieldColor") ?? .white)
            tf.constrainHeight(30)
            tf.clearButtonMode = UITextField.ViewMode.whileEditing
            tf.backgroundColor = UIColor(named: "TextFieldColor")
            tfArray.append(tf)
        }
        
        tfArray[0].placeholder = "Description"
        tfArray[1].placeholder = "Amount"
        

        
        tfArray.forEach { (tf) in
            formContainerStackView.addArrangedSubview(tf)
        }
        formContainerStackView.addArrangedSubview(confirmButton)
    }
    
    func setupTableView() {
        let tableView = UITableView()
        formContainerStackView.addArrangedSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: formContainerStackView.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: formContainerStackView.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: formContainerStackView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: formContainerStackView.rightAnchor).isActive = true
    }
    
    
    @objc fileprivate func datePickerValueChanged(_ sender: UIDatePicker) {
        self.selectedDate = dateFormatter.string(from: sender.date)
    }
    
    @objc fileprivate func closeView() {
        dismiss(animated: true)
    }
    
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


