//
//  menuCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/09/21.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    static let identifier: String = "MenuCell"
    
    @IBOutlet weak var menuLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .greyishBrown
                menuLabel.textColor = .white
            } else {
                backgroundColor = .white
                menuLabel.textColor = .greyishBrown
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBorder()
    }
    
    private func setBorder() {
        
        self.layer.borderColor = UIColor.greyishBrown.cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = .white
        self.layer.cornerRadius = 11
        self.menuLabel.textColor = .greyishBrown
    }
    
    func set(title: String) {
        menuLabel.text = title
    }
}
