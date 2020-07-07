//
//  InventoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {
    
    static let identifier: String = "InventoryCell"
    
    // 코드로 커스텀이 필요한 뷰
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var inventoryAmountLabel: UILabel!
    
    
    // 서버에서 받아서 채워야할 데이터
    @IBOutlet weak var inventoryImageView: UIImageView!
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var minimumInventoryCountLabel: UILabel!
    @IBOutlet weak var inventoryUnitLabel: UILabel!
    @IBOutlet weak var inventoryCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRoundView()
        makeShadowUnderView()
        makeShadowAroundInventoryView()
        setLabelColors()
        
    }

    private func makeShadowAroundInventoryView() {
        
        inventoryView.layer.shadowOffset = CGSize(width: 0, height: 0)
        inventoryView.layer.shadowOpacity = 0.1
        inventoryView.layer.shadowRadius = 15
        
    }
    private func makeRoundView() {
        
        roundView.layer.cornerRadius = 9
        
    }
    
    private func makeShadowUnderView() {
        // 그림자주는 코드
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 15 // 퍼지는 정도
        
    }
    
    private func setLabelColors() {
        
        inventoryNameLabel.textColor = UIColor.charcoal
        minimumInventoryCountLabel.textColor = UIColor.greyishBrown
        inventoryUnitLabel.textColor = UIColor.charcoal
        inventoryCountLabel.textColor = UIColor.pinkishGrey
        inventoryAmountLabel.textColor = UIColor.yellow
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }
    
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String, _ minimumInventoryCount: String, _ orderInventoryCount: String, _ inventoryCount: String) {
        inventoryImageView.image = UIImage(named: inventoryImageName)
        inventoryNameLabel.text = inventoryName
        minimumInventoryCountLabel.text = minimumInventoryCount
        inventoryCountLabel.text = inventoryCount
    }
    

}
