//
//  TagCollectionViewCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tagNameLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                print("select")
                backgroundColor = .greyishBrown
                tagNameLabel.textColor = .white
            } else {
                print("unselect")
                backgroundColor = .white
                tagNameLabel.textColor = .greyishBrown
            }
        }
    }

    func bind(model:CategoryInfo){
        tagNameLabel.text = model.name
    }
    
}
