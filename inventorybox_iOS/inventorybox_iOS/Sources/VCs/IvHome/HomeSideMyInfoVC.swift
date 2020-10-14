//
//  HomeSideMyInfoVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeSideMyInfoVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var bottomLineView: UIView!
    
    var name: String?
    var storeName: String?
    var phone: String?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.nameTextField.endEditing(true)
        self.storeNameTextField.endEditing(true)
        self.phoneTextField.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        getDataFromServer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        storeNameTextField.delegate = self
        locationTextField.delegate = self
        phoneTextField.delegate = self
        
        nameTextField.tintColor = .mediumGrey
        storeNameTextField.tintColor = .mediumGrey
        locationTextField.tintColor = .mediumGrey
        phoneTextField.tintColor = .mediumGrey
        
        bottomLineView.backgroundColor = .veryLightPinkThree
        
        saveButton.isEnabled = false
        
        nameTextField.makeBorder(color: .pinkishGrey)
        storeNameTextField.makeBorder(color: .pinkishGrey)
        phoneTextField.makeBorder(color: .pinkishGrey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getAddress), name: .init("name"), object: nil)
        
    }
    
    @objc private func getAddress(_ notification: Notification) {
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let address = info["address"] as? String else { return }
        locationTextField.text = address
        saveButton.setImage(UIImage.init(named: "btnChangeSaveAfter"), for: .normal)
        saveButton.isEnabled = true
        bottomLineView.backgroundColor = .yellow
        print("ehll")
        
    }
    
    func getDataFromServer(){
        
        IvHomeHamburgerPrivateInformationService.shared.getprivateInformation
        { networkResult in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? PrivateInformationData else { return }
                
                if let n = self.name {
                    self.nameTextField.text = n
                } else {
                    self.nameTextField.text = dt.result[0].repName
                }
                
                if let s = self.storeName {
                    self.storeNameTextField.text = s
                } else {
                    self.storeNameTextField.text = dt.result[0].coName
                }
                
                if let p = self.phone {
                    self.phoneTextField.text = p
                } else {
                    self.phoneTextField.text = dt.result[0].phoneNumber
                }
                
                if let location = dt.result[0].location {
                    self.locationTextField.text = location
                } else {
                    self.locationTextField.text = "위치를 설정해주세요"
                }
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
            
        }
        
    }
    
    
    
    private func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    @IBAction func changeMyInfo(_ sender: UIButton) {
        
        if let name = nameTextField.text, let storeName = storeNameTextField.text, let phone = phoneTextField.text {
            
            IvHomeHamburgerPrivateInformationPutServcie.shared.putPrivateInformation(name: name, storeName: storeName, phone: phone, location: locationTextField.text ?? "") { networkResult in
                switch networkResult {
                case .success(let data):
                    print(data)
                    self.dismiss(animated: true, completion: nil)
                case .requestErr(let message):
                    guard let message = message as? String else {return}
                    print(message)
                case .serverErr: print("serverErr")
                case .pathErr:
                    print("pathErr")
                case .networkFail:
                    print("networkFail")
                }
            }
        } else {
            let alertVC = UIAlertController(title: "오류", message: "값을 입력해주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func selectLocation(_ sender: Any) {
        
        self.nameTextField.endEditing(true)
        self.storeNameTextField.endEditing(true)
        self.phoneTextField.endEditing(true)
        
        let locationST = UIStoryboard.init(name: "IvExchange", bundle: nil)
        guard let dst = locationST.instantiateViewController(identifier: "IvExchangeSearchVC") as? IvExchangeSearchVC else { return }
        
        self.navigationController?.pushViewController(dst, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension HomeSideMyInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.makeBorder(color: .yellow)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        saveButton.setImage(UIImage.init(named: "btnChangeSaveAfter"), for: .normal)
        saveButton.isEnabled = true
        
        if textField == phoneTextField {
            if let phoneNumber = phoneTextField.text {
                phone = phoneNumber
            }
        } else if textField == nameTextField {
            if let name = nameTextField.text {
                self.name = name
            }
        } else if textField == storeNameTextField {
            if let store = storeNameTextField.text {
                storeName = store
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            var strText: String? = textField.text
            if strText == nil {
                strText = ""
            }
            let newString = (strText! as NSString).replacingCharacters(in: range, with: string)
            
            textField.text = format(with: "XXX-XXXX-XXXX", phone: newString)
            return false
        }
        return true
    }
    
    
}

extension UITextField {
    func makeBorder(color: UIColor) {
        self.layer.cornerRadius = self.frame.height / 5
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
}
