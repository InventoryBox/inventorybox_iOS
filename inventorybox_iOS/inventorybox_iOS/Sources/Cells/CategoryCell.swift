//
//  CategoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier: String = "CategoryCell"
    
    @IBOutlet var categoryNameLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .greyishBrown
                categoryNameLabel.textColor = .white
            } else {
                backgroundColor = .white
                categoryNameLabel.textColor = .greyishBrown
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBorder()
        
    }
    
    private func firstLoad() {
        isSelected = true
    }
    private func setBorder() {
        self.layer.borderColor = UIColor.greyishBrown.cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = .white
        self.layer.cornerRadius = 11
        self.categoryNameLabel.textColor = .greyishBrown
    }
    
//    func wholeSetting(_ isColor: Bool) {
//        if categoryNameLabel.text == "전체" {
//            isSelected = isColor
//        } else {
//            isSelected = !isColor
//        }
//
//    }
    
    func setTag(tagName:String){
        categoryNameLabel.text = tagName
    }
}

