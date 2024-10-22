//
//  IconCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol IconSeletDelegate {
    func didSelectIcon(indexPath: Int, iconImageName: String, idx: Int)
}

class IconCell: UICollectionViewCell {
    static let identifier: String = "IconCell"
    
    var delegate: IconSeletDelegate?
    var indexPath: Int?
    var imageName: String?
    var iconIdx: Int?
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.brownGrey.cgColor
        self.layer.cornerRadius = 10
        
    }
    
    func setIcon(_ iconImageName: String) {
        let url = URL(string: iconImageName)
        self.iconImageView.kf.setImage(with: url)
        imageName = iconImageName
    }
    @IBAction func iconSelectBtnPressed(_ sender: Any) {
        delegate?.didSelectIcon(indexPath: indexPath!, iconImageName: imageName!, idx: iconIdx!)
    
    }
}
