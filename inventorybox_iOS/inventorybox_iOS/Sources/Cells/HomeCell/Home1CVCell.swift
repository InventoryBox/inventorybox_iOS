//
//  Home2CVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/10.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class Home1CVCell: UICollectionViewCell {
    
    let identifier : String = "Home1CVCell"
    
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    
    
    func set(checkimg: String, productlist: String){
        checkImg.image = UIImage(named: checkimg)
        productName.text = productlist
    }
}
