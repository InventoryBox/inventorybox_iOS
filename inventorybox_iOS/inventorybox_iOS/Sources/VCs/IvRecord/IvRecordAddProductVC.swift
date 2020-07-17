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
    @IBOutlet weak var inventoryNameTextField: UITextField!
    @IBOutlet weak var lineUnderNameTextFieldView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var iconSelectTitleLabel: UILabel!
    @IBOutlet weak var iconSelectDetailLabel: UILabel!
    @IBOutlet weak var addIconBtn: UIButton!
    
    @IBOutlet weak var unitSelectTitleLabel: UILabel!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var lineUnderUnitTextFieldView: UIView!
    
    @IBOutlet weak var categoryLabel: UILabel!
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
    
    @IBOutlet weak var popupBackgroundView: UIView!
    var iconIdx: Int = 2
    var iconArray: [IconInfo] = [] {
        didSet {
            
        }
    }
    var categories: [CategoryInfo] = [] {
        didSet {
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setViewCustom()
        setLabelCustom()
        setButtonCustom()
        setPopupBackgroundView()
        inventoryNameTextField.delegate = self
        unitTextField.delegate = self
    }
    private func getDataFromServer() {
        
        IvRecordAddIvService.shared.getRecordAddIv() { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? AddIvClass else { return }
                
                self.iconArray = dt.iconInfo
                self.categories = dt.categoryInfo
                
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
        
    }
    
    @objc private func disappearIconIdx(_ notification: Notification) {
        
        guard let info = notification.userInfo as? [String: Any] else {
            return
        }
        guard let ivIconIdx = info["selectedIdx"] as? Int else { return }
//        print(ivIconIdx)
        self.iconIdx = ivIconIdx
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func setViewCustom() {
        
        topView.layer.shadowOffset = CGSize(width: 0, height: 1)
        topView.layer.shadowRadius = 2
        topView.layer.shadowOpacity = 0.16
        
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
    
    private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
        
    }
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
        
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let name = info["categoryName"] as? String else { return }
        categoryLabel.text = name
        
    }
    @IBAction func selectCategory(_ sender: Any) {
        animatePopupBackground(true)

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SelectCategoryVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
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
    @IBAction func dismissBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func inventoryToBuyPlusBtnPressed(_ sender: Any) {
        if let count = inventoryToBuyLabel.text {
            let num: Int = Int(count)!
            
            inventoryToBuyLabel.text = (num + 1) >= 0 ? "\(num + 1)": "0"
            
        }
    }
    @IBAction func registerInventoryBtnPressed(_ sender: Any) {
        guard let ivName = inventoryNameTextField.text else {
            print("이름 입력 오류")
            return
            
        }
        guard let ivUnit = unitTextField.text else {
            print("단위 입력 오류")
            return
        }
        guard let ivMinimum = minimumCountLabel.text else {
            print("발주 알림 개수 입력 오류")
            return
        }
        let alarmCnt = Int(ivMinimum)!
        guard let ivOrder = inventoryToBuyLabel.text else {
            print("발주할 수량 메모 입력 오류")
            return
        }
        
        let memoCnt = Int(ivOrder)!
        var categoryIdx: Int = -1
        
        for i in 0..<categories.count {
            if categoryLabel.text! ==  categories[i].name {
                categoryIdx = categories[i].categoryIdx
                break
            }
        }
        print(ivName)
        print(ivUnit)
        print(alarmCnt)
        print(memoCnt)
        print(iconIdx)
        print(categoryIdx)
        IvRecordAddIvPostService.shared.getRecordAddIvPost(name: ivName, unit: ivUnit, alarmCnt: alarmCnt, memoCnt: memoCnt, iconIdx: iconIdx, categoryIdx: categoryIdx) { (networkResult) in
            switch networkResult {
            case .success(let data):
                print("이건 vc")
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
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
extension IvRecordAddProductVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.unitTextField.endEditing(true)
        self.inventoryNameTextField.endEditing(true)
        return true
    }
}
