//
//  IconCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IconCell: UICollectionViewCell {
    static let identifier: String = "IconCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    func setIcon(_ iconImageName: String) {
        iconImageView.image = UIImage(named: iconImageName)
    }
}
