//
//  AddCategoryPopupVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class AddCategoryPopupVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBtnCustom()
        setViewCustom()
        
    }
    
    private func setViewCustom() {
        
        titleLabel.backgroundColor = UIColor.yellow
        popupView.layer.cornerRadius = 9
        
    }
    private func setBtnCustom() {
        
        cancelBtn.layer.cornerRadius = 17
        addBtn.layer.cornerRadius = 17
        cancelBtn.tintColor = UIColor.black
        addBtn.tintColor = UIColor.white
        
    }

    @IBAction func cancel(_ sender: Any) {
        
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["categoryName": "none"])
        self.dismiss(animated: true)
    }
    @IBAction func addCategory(_ sender: Any) {
        
        guard let name = categoryTextField.text else {
            
            return
        }
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["categoryName": name])
        
        self.dismiss(animated: true)
    }
}
