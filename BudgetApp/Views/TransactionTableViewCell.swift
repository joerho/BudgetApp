//
//  TransactionTableViewCell.swift
//  BudgetApp
//
//  Created by joe rho on 11/2/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(customLabel)
        customLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
        customLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        customLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        customLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
