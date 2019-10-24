//
//  TransactionCategoryRow.swift
//  BudgetApp
//
//  Created by joe rho on 10/23/19.
//  Copyright © 2019 joe rho. All rights reserved.
//

import Eureka

class TransactionCategoryCell: PushSelectorCell<String> {
    
    lazy var categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func setup() {
        height = { 60 }
        row.title = nil
        super.setup()
        selectionStyle = .none
        
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 10.0
        categoryLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -(margin * 2)).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -(margin * 2)).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    override func update() {
        row.title = nil
        accessoryType = .disclosureIndicator
        editingAccessoryType = accessoryType
        selectionStyle = row.isDisabled ? .none : .default
        categoryLabel.text = row.value
    }
}

final class TransactionCategoryRow: _PushRow<TransactionCategoryCell>, RowType { }
