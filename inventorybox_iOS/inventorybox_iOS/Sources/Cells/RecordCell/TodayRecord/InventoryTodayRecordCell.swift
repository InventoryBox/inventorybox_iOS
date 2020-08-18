//
//  IvTodayRecordCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol FilledTextFieldDelegate {

    func isTextFieldFilled(count: Int, isTyped: Bool, indexPath: Int)
    func isTextFieldFilled(count: Int, indexPath: Int)
    
}

extension FilledTextFieldDelegate {
  
    func isTextFieldFilled(count: Int, isTyped: Bool, indexPath: Int) { }
    func isTextFieldFilled(count: Int, indexPath: Int) { }
    
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
    
    var ivCnt: Int?
    var isTyped: Bool = false {
        didSet {
            if isTyped {
                if let cnt = ivCnt {
                    inventoryCountTextField.text = "\(cnt)"
                }
            } else {
                inventoryCountTextField.text = ""
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRoundView()
        makeShadowUnderView()
        makeShadowAroundInventoryView()
        setTextFieldCustommed()
        
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
    
    private func makeShadowAroundInventoryView() {
        
        inventoryView.layer.shadowOffset = CGSize(width: 0, height: 0)
        inventoryView.layer.shadowOpacity = 0.1
        inventoryView.layer.shadowRadius = 15
        
    }
    
    private func setTextFieldCustommed() {
        
        inventoryCountTextField.layer.cornerRadius = 9
        inventoryCountTextField.borderStyle = .none
        inventoryCountTextField.textAlignment = .center
        inventoryCountTextField.tintColor = UIColor.greyishBrown
        inventoryCountTextField.delegate = self
        inventoryCountTextField.keyboardType = .numberPad
    
        // keyboard toolbar
        let toolbarKeyboard = UIToolbar()
        toolbarKeyboard.sizeToFit()
        let btnDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneBtnPressed))
        
    }
    
    @objc func doneBtnPressed() {
        
        self.contentView.endEditing(true)
        
    }
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String) {
        
        let url = URL(string: inventoryImageName)
        self.inventoryImageView.kf.setImage(with: url)
        inventoryNameLabel.text = inventoryName
        isTyped = false
        
    }

}

extension InventoryTodayRecordCell: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.contentView.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    // 재고량이 입력 되었으면 재고량을 보내주고, 입력되지 않았다면 -1을 보내준다.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let text = textField.text {
            if let cnt = Int(text) {
                delegate?.isTextFieldFilled(count: cnt, indexPath: indexPath!)
            } else {
                let cnt: Int = -1
                delegate?.isTextFieldFilled(count: cnt, indexPath: indexPath!)
            }
        }
        
    }
    
}
