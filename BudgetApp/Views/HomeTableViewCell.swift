//
//  HomeTableViewCell.swift
//  BudgetApp
//
//  Created by joe rho on 3/7/20.
//  Copyright © 2020 joe rho. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.systemGray
        
        return label
    }()
    
    let content: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        addSubview(content)
        
        title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        content.heightAnchor.constraint(equalToConstant: 40).isActive = true
        content.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        content.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

