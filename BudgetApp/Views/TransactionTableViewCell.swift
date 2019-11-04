//
//  TransactionTableViewCell.swift
//  BudgetApp
//
//  Created by joe rho on 11/2/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
