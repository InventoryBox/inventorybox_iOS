//
//  InventoryCategoryEditCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox


@objc protocol CellButtonDelegate {
    @objc func didClickCheckButton(isClicked: Bool, indexPath: Int)
    @objc func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: Int)
}

extension CellButtonDelegate {
    func didClickCheckButton(isClicked: Bool, indexPath: Int) {}
    func didAllBtnClickedCheckButton() {}
}


class InventoryCategoryEditCell: UITableViewCell {
    static let identifier: String = "InventoryCategoryEditCell"
    
    var delegate: CellButtonDelegate?
    var indexPath: Int?
    
    // 코드로 커스텀이 필요한 뷰
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var inventoryView: UIView!
    
    // 서버에서 받아서 채워야할 데이터
    @IBOutlet weak var inventoryImageView: UIImageView!
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var minimumInventoryCountLabel: UILabel!
    @IBOutlet weak var inventoryUnitLabel: UILabel!
    @IBOutlet weak var selectedCheckBox: BEMCheckBox!
    
    var isSelectBtn: Bool = false {
        didSet {
            selectedCheckBox.on = isSelectBtn
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView.layer.cornerRadius = 9
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 15 // 퍼지는 정도
        inventoryView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        inventoryView.layer.shadowOpacity = 0.16
        inventoryView.layer.shadowRadius = 15
        inventoryNameLabel.textColor = UIColor.charcoal
        minimumInventoryCountLabel.textColor = UIColor.greyishBrown
        inventoryUnitLabel.textColor = UIColor.charcoal
        selectedCheckBox.onCheckColor = UIColor.white
        selectedCheckBox.onFillColor = UIColor.yellow
        selectedCheckBox.onTintColor = UIColor.yellow
    }

    @IBAction func turnCheckbox(_ sender: Any) {
        
        if selectedCheckBox.on {
            isSelectBtn = true
        } else {
            isSelectBtn = false
        }
        
        delegate?.didClickCheckButton(isClicked: isSelectBtn, indexPath: indexPath!)
    }
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String, _ inventoryUnit: String, _ minimumInventoryCount: Int) {
        let url = URL(string: inventoryImageName)
        self.inventoryImageView.kf.setImage(with: url)
        inventoryNameLabel.text = inventoryName
        inventoryUnitLabel.text = inventoryUnit
        minimumInventoryCountLabel.text = "\(minimumInventoryCount)"
    }
    
}
