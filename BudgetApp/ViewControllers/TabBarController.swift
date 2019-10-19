//
//  TabBarController.swift
//  BudgetApp
//
//  Created by joe rho on 10/9/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit
import SQLite

class TabBarController: UITabBarController{
    
    
    var item1: UIViewController?
    var item2: UIViewController?
    var item3: UIViewController?
    var controllers:[UIViewController] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        item1 = UINavigationController(rootViewController: ExpenseViewController())
        item2 = HomeViewController()
        item3 = UINavigationController(rootViewController: IncomeViewController())
        
        item1?.tabBarItem = UITabBarItem(title: "expense", image: UIImage(systemName: "chevron.down.square.fill"), tag: 0)
        item2?.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "chart.pie"), tag: 1)
        item3?.tabBarItem = UITabBarItem(title: "income", image: UIImage(systemName: "chevron.up.square.fill"), tag: 2)

        controllers.append(item1!)
        controllers.append(item2!)
        controllers.append(item3!)

        self.viewControllers = controllers
        
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    
