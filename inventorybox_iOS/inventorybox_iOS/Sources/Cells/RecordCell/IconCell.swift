//
//  IconCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol IconSeletDelegate {
    func didSelectIcon(indexPath: Int, iconImageName: String)
}
class IconCell: UICollectionViewCell {
    static let identifier: String = "IconCell"
    
    var delegate: IconSeletDelegate?
    var indexPath: Int?
    var imageName: String?
    @IBOutlet weak var iconImageView: UIImageView!
    
    func setIcon(_ iconImageName: String) {
        iconImageView.image = UIImage(named: iconImageName)
        imageName = iconImageName
    }
    @IBAction func iconSelectBtnPressed(_ sender: Any) {
        print("tap")
        delegate?.didSelectIcon(indexPath: indexPath!, iconImageName: imageName!)
    
    }
}
