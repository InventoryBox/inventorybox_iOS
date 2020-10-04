//
//  InventoryEditProductCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class InventoryEditProductCell: UITableViewCell {
    static let identifier: String = "InventoryEditProductCell"
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var inventoryImageView: UIImageView!
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var inventoryCountTextField: UITextField!
    
    var delegate: FilledTextFieldDelegate?
    var indexPath: Int?
    
    var ivCnt: Int?
    var isTyped: Bool = false {
        didSet {
            if isTyped {
                if let cnt = ivCnt {
                    inventoryCountTextField.text = cnt == -1 ? "" : "\(cnt)"
                }
            } else {
                inventoryCountTextField.text = ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView.layer.cornerRadius = 9
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 15 // 퍼지는 정도
        inventoryView.layer.shadowOffset = CGSize(width: 0, height: 0)
        inventoryView.layer.shadowOpacity = 0.1
        inventoryView.layer.shadowRadius = 15
        setTextFieldCustommed()
    }
    
    private func setTextFieldCustommed() {
        
        inventoryCountTextField.layer.borderWidth = 1
        inventoryCountTextField.layer.borderColor = UIColor.yellow.cgColor
        inventoryCountTextField.layer.cornerRadius = 15
        inventoryCountTextField.placeholder = "재고량 입력"
        inventoryCountTextField.layer.cornerRadius = 9
        inventoryCountTextField.borderStyle = .none
        inventoryCountTextField.textAlignment = .center
        inventoryCountTextField.tintColor = UIColor.greyishBrown
        inventoryCountTextField.keyboardType = .numberPad
        inventoryCountTextField.addInputAccessoryView(title: "완료", target: self, selector: #selector(donePressed))
        inventoryCountTextField.delegate = self
    }
    
    @objc private func donePressed() {
        self.contentView.endEditing(true)
    }
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String) {
        let url = URL(string: inventoryImageName)
        self.inventoryImageView.kf.setImage(with: url)
        inventoryNameLabel.text = inventoryName
        isTyped = false
    }

}

extension InventoryEditProductCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = inventoryCountTextField.text {
            if let cnt = Int(text) {
                delegate?.isTextFieldFilled(count: cnt, indexPath: indexPath!)
            } else {
                let cnt: Int = -1
                delegate?.isTextFieldFilled(count: cnt, indexPath: indexPath!)
            }
        }
    }
}

