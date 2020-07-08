//
//  IvRecordAddProductVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvRecordAddProductVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var inventoryNameTextField: UITextField!
    @IBOutlet weak var lineUnderNameTextFieldView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var iconSelectTitleLabel: UILabel!
    @IBOutlet weak var iconSelectDetailLabel: UILabel!
    @IBOutlet weak var addIconBtn: UIButton!
    
    @IBOutlet weak var unitSelectTitleLabel: UILabel!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var lineUnderUnitTextFieldView: UIView!
    
    @IBOutlet weak var categorySelectTitleLabel: UILabel!
    @IBOutlet weak var categorySelectDetailLabel: UILabel!
    
    @IBOutlet weak var inventoryMinimumCountTitleLabel: UILabel!
    @IBOutlet weak var inventoryMinimumCountDetailLabel: UILabel!
    @IBOutlet weak var minimumCountMinusBtn: UIButton!
    @IBOutlet weak var minimumCountPlusBtn: UIButton!
    @IBOutlet weak var minimumCountLabel: UILabel!
    
    
    @IBOutlet weak var inventoryToBuyMinusBtn: UIButton!
    @IBOutlet weak var inventoryToBuyPlusBtn: UIButton!
    @IBOutlet weak var inventoryToBuyLabel: UILabel!
    
    @IBOutlet weak var registerInventoryBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewCustom()
        setLabelCustom()
        setButtonCustom()
        
    }
    
    @IBAction func registerInventoryBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func setViewCustom() {
        
        topView.layer.shadowOffset = CGSize(width: 0, height: 1)
        topView.layer.shadowRadius = 2
        topView.layer.shadowOpacity = 0.1
        
        middleView.layer.shadowOffset = CGSize(width: 0, height: 3)
        middleView.layer.shadowRadius = 15
        middleView.layer.shadowOpacity = 0.1
        
        lineUnderNameTextFieldView.backgroundColor = UIColor.yellow
        lineUnderUnitTextFieldView.backgroundColor = UIColor.yellow
        
    }
    
    private func setButtonCustom() {
        
        addIconBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        addIconBtn.layer.shadowRadius = 15
        addIconBtn.layer.shadowOpacity = 0.1
        
        registerInventoryBtn.backgroundColor = UIColor.yellow
        registerInventoryBtn.layer.cornerRadius = 25
        registerInventoryBtn.tintColor = UIColor.white
        
        minimumCountMinusBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        minimumCountMinusBtn.layer.shadowRadius = 2
        minimumCountMinusBtn.layer.shadowOpacity = 0.1
        
        minimumCountPlusBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        minimumCountPlusBtn.layer.shadowRadius = 2
        minimumCountPlusBtn.layer.shadowOpacity = 0.1
    }
    
    private func setLabelCustom() {
        
        self.titleViewLabel.text = "발주 확인"
        self.titleViewLabel.tintColor = UIColor.charcoal
        
        self.iconSelectTitleLabel.textColor = UIColor.greyishBrown
        self.iconSelectDetailLabel.textColor = UIColor.greyishBrown
        
        self.unitSelectTitleLabel.textColor = UIColor.greyishBrown
        
        self.categorySelectTitleLabel.textColor = UIColor.greyishBrown
        self.categorySelectDetailLabel.textColor = UIColor.greyishBrown
        
        self.inventoryMinimumCountTitleLabel.textColor = UIColor.greyishBrown
        self.inventoryMinimumCountDetailLabel.textColor = UIColor.greyishBrown
        
        
        
        
    }
    @IBAction func minimumCountMinusBtnPressed(_ sender: Any) {
        
        if let count = minimumCountLabel.text {
            let num: Int = Int(count)!
            
            minimumCountLabel.text = (num - 1) >= 0 ? "\(num - 1)": "0"
            
        }
        
    }
    
    @IBAction func minimumCountPlusBtnPressed(_ sender: Any) {
        
        if let count = minimumCountLabel.text {
            let num: Int = Int(count)!
            
            minimumCountLabel.text = (num + 1) >= 0 ? "\(num + 1)": "0"
            
        }
    }
    @IBAction func inventoryToBuyMinusBtnPressed(_ sender: Any) {
        if let count = inventoryToBuyLabel.text {
            let num: Int = Int(count)!
            
            inventoryToBuyLabel.text = (num - 1) >= 0 ? "\(num - 1)": "0"
            
        }
    }
    @IBAction func inventoryToBuyPlusBtnPressed(_ sender: Any) {
        if let count = inventoryToBuyLabel.text {
            let num: Int = Int(count)!
            
            inventoryToBuyLabel.text = (num + 1) >= 0 ? "\(num + 1)": "0"
            
        }
    }
    @IBAction func addInventoryBtnPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true) {
            // 재료 저장 post
        }
        
    }
}
