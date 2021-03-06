//
//  TransactionTableViewCell.swift
//  BudgetApp
//
//  Created by joe rho on 11/2/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    let amount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = label.font.withSize(12)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(amount)
        contentView.addSubview(emojiLabel)
        amount.topAnchor.constraint(equalTo: self.textLabel!.topAnchor).isActive = true
        amount.heightAnchor.constraint(equalToConstant: 30).isActive = true
        amount.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        amount.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true
        
        emojiLabel.topAnchor.constraint(equalTo: self.detailTextLabel!.topAnchor).isActive = true
        emojiLabel.heightAnchor.constraint(equalTo: self.detailTextLabel!.heightAnchor).isActive = true
        emojiLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        emojiLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
