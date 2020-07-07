//
//  RightCVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class RightCVCell: UICollectionViewCell {
    
    
    
    static let identifier : String = "RightCVCell"
     
     
     @IBOutlet weak var checkBtn: UIImageView!
     @IBOutlet weak var productText: UILabel!
     
     
    func set(checkimg: String, productlist: String){
           checkBtn.image = UIImage(named: checkimg)
           productText.text = productlist
       }
}
