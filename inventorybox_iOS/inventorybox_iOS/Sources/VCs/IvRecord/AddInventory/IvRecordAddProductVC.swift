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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
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
    @IBOutlet weak var minimumCountLabel: UITextField!
    
    
    @IBOutlet weak var inventoryToBuyMinusBtn: UIButton!
    @IBOutlet weak var inventoryToBuyPlusBtn: UIButton!
    @IBOutlet weak var inventoryToBuyLabel: UITextField!
    
    @IBOutlet weak var registerInventoryBtn: UIButton!
    
    @IBOutlet weak var popupBackgroundView: UIView!
    
    var iconIdx: Int = 0
    var categoryIdx: Int = 0
    var iconArray: [IconInfo] = []
    var categories: [CategoryInfo] = []
    
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
        minimumCountLabel.delegate = self
        inventoryToBuyLabel.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapMethod))
        self.scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let keyboardHeight = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func myTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
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
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let ivIconIdx = info["selectedIdx"] as? Int else { return }
        print(ivIconIdx)
        self.iconIdx = ivIconIdx
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setViewCustom() {
        middleView.layer.shadowOffset = CGSize(width: 0, height: 3)
        middleView.layer.shadowRadius = 15
        middleView.layer.shadowOpacity = 0.1
        lineUnderNameTextFieldView.backgroundColor = UIColor.yellow
        lineUnderUnitTextFieldView.backgroundColor = UIColor.yellow
    }
    
    private func setButtonCustom() {
        registerInventoryBtn.backgroundColor = UIColor.yellow
        registerInventoryBtn.layer.cornerRadius = 25
        registerInventoryBtn.tintColor = UIColor.white
        addIconBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        addIconBtn.layer.shadowRadius = 15
        addIconBtn.layer.shadowOpacity = 0.1
        minimumCountMinusBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        minimumCountMinusBtn.layer.shadowRadius = 2
        minimumCountMinusBtn.layer.shadowOpacity = 0.1
        minimumCountPlusBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        minimumCountPlusBtn.layer.shadowRadius = 2
        minimumCountPlusBtn.layer.shadowOpacity = 0.1
    }
    
    private func setLabelCustom() {
        self.titleViewLabel.text = "재료 추가"
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
        NotificationCenter.default.addObserver(self, selector: #selector(getIconIdx), name: .init("iconidx"), object: nil)
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
        
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let name = info["categoryName"] as? String else { return }
        guard let idx = info["categoryIdx"] as? Int else { return }
        categoryLabel.text = name
        categoryIdx = idx
        
    }
    
    @objc private func getIconIdx(_ notification: Notification) {
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let idx = info["iconIdx"] as? Int else { return }
        iconIdx = idx
        var temp: Int = 0
        for i in 0..<iconArray.count {
            if iconArray[i].iconIdx == idx {
                temp = i
                break
            }
        }
        addIconBtn.setTitle("", for: .normal)
        let url = URL(string: iconArray[temp].img)
        self.iconImageView.kf.setImage(with: url)
        
    }
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
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
        
        if ivName == "" || ivUnit == "" {
            let alertViewController = UIAlertController(title: "재료추가 실패", message: "값들을 전부 적어주세요!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        } else if alarmCnt == 0 {
            let alertViewController = UIAlertController(title: "재료추가 실패", message: "발주 알림 개수를 선택해주세요!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        } else if memoCnt == 0 {
            let alertViewController = UIAlertController(title: "재료추가 실패", message: "수량 메모 개수를 선택해주세요!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        }
        
        else if iconIdx == 0 {
            let alertViewController = UIAlertController(title: "재료추가 실패", message: "아이콘을 선택해주세요!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        } else {
            IvRecordAddIvPostService.shared.getRecordAddIvPost(name: ivName, unit: ivUnit, alarmCnt: alarmCnt, memoCnt: memoCnt, iconIdx: iconIdx, categoryIdx: categoryIdx) { (networkResult) in
                switch networkResult {
                case .success(let data):
                    // 성공메세지
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
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                NotificationCenter.default.post(name: .init("sendDataFromAddIvToEdit"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
}

extension IvRecordAddProductVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.unitTextField.endEditing(true)
        self.inventoryNameTextField.endEditing(true)
        self.minimumCountLabel.endEditing(true)
        self.inventoryToBuyLabel.endEditing(true)
        return true
    }
}
