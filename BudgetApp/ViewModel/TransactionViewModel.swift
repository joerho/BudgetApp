//
//  TransactionViewModel.swift
//  BudgetApp
//
//  Created by joe rho on 10/16/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Foundation


public class TransactionViewModel {
    
    private let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    public var description: String {
        return transaction.description
    }
    
    public var amount: String {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 2
        
        return "$" + nf.string(from: transaction.amount)!
    }
    
    public var date: String {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        
        return df.string(from: transaction.date)
    }
    
    
    
    
    
    
    
    
}
