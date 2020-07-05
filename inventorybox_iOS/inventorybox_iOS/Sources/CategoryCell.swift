//
//  CategoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier: String = "CategoryCell"
    
    @IBOutlet weak var categoryBtn: UIButton!
    
    
    func setCategories(_ name: String) {
        categoryBtn.titleLabel?.text = name
        categoryBtn.backgroundColor = .gray
        categoryBtn.layer.cornerRadius = 10
        categoryBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        print("Button Tapped")
    }
}