//
//  TransactionTableViewCell.swift
//  BudgetApp
//
//  Created by joe rho on 11/2/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    var customLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        customLabel = UILabel(frame: CGRect(x: self.frame.width - 15, y: 0, width: 60.0, height: 40))
        customLabel.textAlignment = .right
        addSubview(customLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
