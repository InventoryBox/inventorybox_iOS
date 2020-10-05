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

        cancelBtn.layer.cornerRadius = 15
        addBtn.layer.cornerRadius = 15
        cancelBtn.tintColor = UIColor.black
        addBtn.tintColor = UIColor.white
        popupView.layer.cornerRadius = 9
        
    }

    @IBAction func cancel(_ sender: Any) {
        NotificationCenter.default.post(name: .init("popupFromAddCateToEditCate"), object: nil, userInfo: ["categoryName": "none"])
        self.dismiss(animated: false)
    }
    
    @IBAction func addCategory(_ sender: Any) {
        
        guard let name = categoryTextField.text else { return }
        if name == "" {
            categoryTextField.placeholder = "카테고리를 입력해주세요!!"
            print("no Category Name")
        } else {
            IvRecordAddCateService.shared.getRecordAddCate(name: name) { (networkResult) in
                switch networkResult {
                case .success(let data):
                    print(data)
                    
                case .requestErr(let message):
                    guard let message = message as? String else { return }
                    let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                    
                case .pathErr: print("path")
                case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
                }
            }
            NotificationCenter.default.post(name: .init("popupFromAddCateToEditCate"), object: nil, userInfo: ["categoryName": name])
            self.dismiss(animated: false)
        }
        
    }
}
