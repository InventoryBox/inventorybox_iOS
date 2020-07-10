//
//  HomeTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class Home2TVCell: UITableViewCell {

    static let identifier : String = "Home2TVCell"
    
    @IBOutlet weak var roundView: UIView!
    
    @IBOutlet weak var productImg: UIImageView!     // 제품 이미지
    @IBOutlet weak var productNameText: UILabel!    // 제품 이름
    @IBOutlet weak var productCountText: UILabel!   // 제품 개수
    @IBOutlet weak var productSetText: UILabel!     // 제품 묶음
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        makeShadowUnderView()
        
    }
    private func makeShadowUnderView() {
        // 그림자주는 코드
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 8// 퍼지는 정도
        
        roundView.layer.cornerRadius = 10
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func SetProductImformation(productImage: String, productNameTx: String, productCountTx: String, productSetTx: String) {

        productImg.image = UIImage(named: productImage)
        productNameText.text = productNameTx
        productCountText.text = productCountTx  // int형으로 받아야 함
        productSetText.text = productNameTx
    }
    
}

