//
//  IvTodayRecordCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class InventoryTodayRecordCell: UITableViewCell {
    static let identifier: String = "InventoryTodayRecordCell"
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var inventoryImageView: UIImageView!
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var inventoryCountTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRoundView()
        makeShadowUnderView()
        makeShadowAroundInventoryView()
        setTextFieldCustommed()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setTextFieldCustommed() {
        
        inventoryCountTextField.layer.cornerRadius = 9
        inventoryCountTextField.borderStyle = .none
        inventoryCountTextField.textAlignment = .center
        inventoryCountTextField.placeholder = "재고량 입력"
        
        inventoryCountTextField.tintColor = UIColor.greyishBrown
        
        inventoryCountTextField.keyboardType = .numberPad
        inventoryCountTextField.returnKeyType = .done
        inventoryCountTextField.endEditing(true)
    }
    private func makeShadowAroundInventoryView() {
        
        inventoryView.layer.shadowOffset = CGSize(width: 0, height: 0)
        inventoryView.layer.shadowOpacity = 0.1
        inventoryView.layer.shadowRadius = 15
        
    }
    
    private func makeShadowUnderView() {
        // 그림자주는 코드
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 15 // 퍼지는 정도
        
    }
    
    private func makeRoundView() {
        
        roundView.layer.cornerRadius = 9
        
    }
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String) {
        
        inventoryImageView.image = UIImage(named: inventoryImageName)
        inventoryNameLabel.text = inventoryName
        
    }
    
}
