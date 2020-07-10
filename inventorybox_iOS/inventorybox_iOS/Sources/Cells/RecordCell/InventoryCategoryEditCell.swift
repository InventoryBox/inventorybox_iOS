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
    @objc func didClickCheckButton(isClicked: Bool, indexPath: IndexPath)
    @objc func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: IndexPath)
}

extension CellButtonDelegate {
    func didClickCheckButton(isClicked: Bool, indexPath: IndexPath) {}
    func didAllBtnClickedCheckButton() {}
}


class InventoryCategoryEditCell: UITableViewCell {
    static let identifier: String = "InventoryCategoryEditCell"
    
    var delegate: CellButtonDelegate?
    var indexPath: IndexPath?
    
    // 코드로 커스텀이 필요한 뷰
    @IBOutlet weak var roundView: UIView!
    
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
        // Initialization code
        
        makeRoundView()
        makeShadowUnderView()
        setLabelColors()
        setCheckBox()
        
    }

    @IBAction func turnCheckbox(_ sender: Any) {
        
        if selectedCheckBox.on {
            isSelectBtn = true
            
            print(isSelectBtn)
        } else {
            isSelectBtn = false
            
            print(isSelectBtn)
        }
        
        
        delegate?.didClickCheckButton(isClicked: isSelectBtn, indexPath: indexPath!)
    }
    
    private func setCheckBox() {
        
        self.selectedCheckBox.onCheckColor = UIColor.white
        self.selectedCheckBox.onFillColor = UIColor.yellow
        self.selectedCheckBox.onTintColor = UIColor.yellow
        
    }
    private func makeRoundView() {
        
        roundView.layer.cornerRadius = 9
        //roundView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        
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
        
    }
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String, _ minimumInventoryCount: String, checkboxSelected: Bool) {
        inventoryImageView.image = UIImage(named: inventoryImageName)
        inventoryNameLabel.text = inventoryName
        minimumInventoryCountLabel.text = minimumInventoryCount
        isSelectBtn = checkboxSelected
    }
    
}
