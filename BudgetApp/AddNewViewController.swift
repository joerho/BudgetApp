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

class AddNewViewController: LBTAFormController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "CustomColorForLBTA")
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 66))
        let navItem = UINavigationItem(title: "Add New")
        let rightButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        navItem.rightBarButtonItem = rightButton
        navBar.items = [navItem]
        self.view.addSubview(navBar)
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        
        (0...3).forEach {(_) in
            let tf = IndentedTextField(placeholder: "enter text", padding: 12, cornerRadius: 5,  backgroundColor: UIColor(named: "TextFieldColor") ?? .white)

            tf.constrainHeight(50)

            formContainerStackView.addArrangedSubview(tf)
            
        }
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


