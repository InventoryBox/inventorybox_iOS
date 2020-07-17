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
    
    
    
    func set(checkimg: Int, productlist: String){
        if checkimg == 0{
        checkImg.image = UIImage(named: "homeIcUnable.png")   // 이미지 변환 해야함
        }else{
           checkImg.image = UIImage(named: "homeIcAble.png")   // 이미지 변환
        }
        productName.text = productlist
    }
}
