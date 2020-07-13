//
//  IvTodayRecordCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol FilledTextFieldDelegate {
    func isTextFieldFilled(count: String, isTyped: Bool,indexPath: Int)
}

class InventoryTodayRecordCell: UITableViewCell {
    static let identifier: String = "InventoryTodayRecordCell"
    
    var delegate: FilledTextFieldDelegate?
    var indexPath: Int?
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var inventoryImageView: UIImageView!
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var inventoryCountTextField: UITextField!
    
    var isTypedTextField: String = "" {
        didSet {
            inventoryCountTextField.text = isTypedTextField
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRoundView()
        makeShadowUnderView()
        makeShadowAroundInventoryView()
        setTextFieldCustommed()
        
    }
    
    private func setTextFieldCustommed() {
        
        inventoryCountTextField.layer.cornerRadius = 9
        inventoryCountTextField.borderStyle = .none
        inventoryCountTextField.textAlignment = .center
        inventoryCountTextField.placeholder = "재고량 입력"
        
        inventoryCountTextField.tintColor = UIColor.greyishBrown
        
        inventoryCountTextField.keyboardType = .numberPad
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        let doneBtn = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        inventoryCountTextField.inputAccessoryView = toolbar
        inventoryCountTextField.delegate = self
    }
    
    @objc private func donePressed() {
        self.inventoryCountTextField.endEditing(true)
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
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String, _ inventoryCount: String) {
        
        inventoryImageView.image = UIImage(named: inventoryImageName)
        inventoryNameLabel.text = inventoryName
        inventoryCountTextField.text = inventoryCount
        
    }
    
}

extension InventoryTodayRecordCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if inventoryCountTextField.text == "" {
            delegate?.isTextFieldFilled(count: "", isTyped: false, indexPath: indexPath!)
        } else {
            guard let text = textField.text else { return }
            delegate?.isTextFieldFilled(count: text, isTyped: true, indexPath: indexPath!)
        }
    }
    
}
