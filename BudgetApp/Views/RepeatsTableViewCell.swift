//
//  SettingTableViewCell.swift
//  BudgetApp
//
//  Created by joe rho on 3/27/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import Foundation
import UIKit

class RepeatsTableViewCell: UITableViewCell {
    
    let amount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    let frequency: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(amount)
        contentView.addSubview(frequency)
        amount.topAnchor.constraint(equalTo: self.textLabel!.topAnchor).isActive = true
        amount.heightAnchor.constraint(equalToConstant: 30).isActive = true
        amount.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        amount.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true
        
        frequency.topAnchor.constraint(equalTo: self.detailTextLabel!.topAnchor).isActive = true
        frequency.heightAnchor.constraint(equalTo: self.detailTextLabel!.heightAnchor).isActive = true
        frequency.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        frequency.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
