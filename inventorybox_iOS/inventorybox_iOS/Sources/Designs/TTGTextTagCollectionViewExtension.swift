//
//  CategoryCollectionViewExtension.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import TTGTagCollectionView

extension TTGTextTagCollectionView {
    
    func setCategoryCollectionView() {
        
        self.alignment = .fillByExpandingWidth
        self.numberOfLines = 1
        self.scrollDirection = TTGTagCollectionScrollDirection.horizontal
        self.showsHorizontalScrollIndicator = false
    
    }
    
    func setCategoryConfig() -> TTGTextTagConfig {
        let config = TTGTextTagConfig()
        config.borderColor = UIColor.veryLightPink
        config.textColor = UIColor.black
        config.selectedTextColor = UIColor.white
        config.backgroundColor = UIColor.white
        config.selectedBackgroundColor = UIColor.greyishBrown
        config.borderWidth = 1
        config.cornerRadius = 20
        config.enableGradientBackground = false
        config.shadowOpacity = 0
        config.shadowOffset = CGSize(width: 0, height: 0)
        config.selectedCornerRadius = 20
        config.exactHeight = 24
        config.minWidth = 56
        config.extraSpace = CGSize(width: 30, height: 0)
        config.textFont = UIFont(name: "Helvetica Neue", size: 11.0)
        return config
    }
}
