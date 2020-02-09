//
//  HomeViewController.swift
//  BudgetApp
//
//  Created by joe rho on 10/10/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    
    let barChartView = BarChartView()
    var dataEntry: [BarChartDataEntry] = []
    
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()
    
//    convenience init() {
//        self.init()
//    }
    // MARK: -Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold)
        initialize()

    }
    
    private func initialize() {
        view.addSubview(barChartView)
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        barChartView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        barChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.title = "Home"
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: Double(i), label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        barChartView.data = pieChartData
        
    }
    
    func calculateTotalExpenses() -> Int {
        return 0
    }
    
    func calculateTotalIncome() -> Int{
        return 0
    }
    
}
