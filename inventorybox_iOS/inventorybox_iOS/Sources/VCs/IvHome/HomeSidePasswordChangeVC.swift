//
//  HomeSidePasswordChangeVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeSidePasswordChangeVC: UIViewController {

    @IBOutlet weak var emailCheckButton: UIButton!
    @IBOutlet weak var emailBottomLineView: UIView!
    @IBOutlet weak var verifyNumberCheckButton: UIButton!
    @IBOutlet weak var verifyBottomLineView: UIView!
    @IBOutlet weak var emailCheckLabel: UILabel!
    @IBOutlet weak var verifyNumberCheckLabel: UILabel!
    
    @IBOutlet weak var emailTextField: FormTextField!
    @IBOutlet weak var verifyNumberTextField: FormTextField!
    @IBOutlet weak var verifyStackView: UIStackView!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: FormTextField!
    @IBOutlet weak var passwordCheckTextField: FormTextField!
    
    var verifyNumber: Int?
    var isChecked: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        emailCheckButton.layer.cornerRadius = emailCheckButton.frame.height / 2
        verifyNumberCheckButton.layer.cornerRadius = verifyNumberCheckButton.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 8
        passwordCheckTextField.layer.cornerRadius = passwordCheckTextField.frame.height / 8
        
        emailTextField.delegate = self
        verifyNumberTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        
        verifyStackView.isHidden = true
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        passwordCheckTextField.isHidden = true
        emailCheckLabel.isHidden = true
        verifyNumberCheckLabel.isHidden = true
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkEmail(_ sender: UIButton) {
        
        if isValidEmail(id: emailTextField.text) {
            
            self.emailCheckLabel.text = "인증번호를 전송했습니다."
            self.emailCheckLabel.textColor = .yellow
            self.emailCheckLabel.isHidden = false
            
            self.emailBottomLineView.backgroundColor = .yellow
            
            self.verifyStackView.isHidden = false
            
            emailAuthService.shared.getRecordEditIvPost(data: emailTextField.text!, completion: { networkResult in switch networkResult {
                
            case .success(let verify):
                guard let data = verify as? reciveData else {return}
                self.verifyNumber = data.number
                print(self.verifyNumber!)
            case .requestErr(let message):
                guard let message = message as? String else { return }
                print(message)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
                }
            })
        } else {
            emailCheckButton.isEnabled = true
            
            emailCheckLabel.text = "올바른 이메일을 입력해주세요."
            emailCheckLabel.textColor = .red
            emailCheckLabel.isHidden = false
            
            emailBottomLineView.backgroundColor = .red
        }
    }
    
    @IBAction func verifyNumberPressed(_ sender: UIButton) {
        if let number = verifyNumberTextField.text {
            if number == "" {
                
                verifyBottomLineView.backgroundColor = .red
                
                verifyNumberCheckLabel.text = "인증번호가 일치하지 않습니다."
                verifyNumberCheckLabel.textColor = .red
                verifyNumberCheckLabel.isHidden = false
            } else if Int(number) == verifyNumber {
                
                isChecked = true
                
                verifyBottomLineView.backgroundColor = .yellow
                
                verifyNumberCheckLabel.text = "이메일 인증이 완료되었습니다."
                verifyNumberCheckLabel.textColor = .yellow
                verifyNumberCheckLabel.isHidden = false
                
                passwordLabel.isHidden = false
                passwordTextField.isHidden = false
                passwordCheckTextField.isHidden = false
                
                verifyNumberCheckButton.isEnabled = false
                emailCheckButton.isEnabled = false
                verifyNumberCheckButton.backgroundColor = .veryLightPinkTwo
                emailCheckButton.backgroundColor = .veryLightPinkTwo
                
            } else {
                
                verifyBottomLineView.backgroundColor = .red
                
                verifyNumberCheckLabel.text = "인증번호가 일치하지 않습니다."
                verifyNumberCheckLabel.textColor = .red
                verifyNumberCheckLabel.isHidden = false
            }
        } else {
            
            verifyBottomLineView.backgroundColor = .red
            
            verifyNumberCheckLabel.text = "인증번호가 일치하지 않습니다."
            verifyNumberCheckLabel.textColor = .red
            verifyNumberCheckLabel.isHidden = false
        }
    }
    
    func isValidEmail(id: String?) -> Bool {
        guard id != nil else { return false }
        //받아오는 id값이 비어있으면 안되겠쥬?
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        //이메일 정규표현식
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        //NSPredicate는 검색 조건을 텍스트로 입력하여 검색할 수 있게하는거라구 한다..SQL문이라
        // 너무 자세하게하면 어렵다구한다..
        // %@는 하나의 객체로 치환해주는 역할을 함.
        return pred.evaluate(with: id)
        // id 값이 pred의 값과 일치하는지 않하는지 여부를 판단해줌
        // 결과값이 true false로 나옴
    }
    
}

extension HomeSidePasswordChangeVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailBottomLineView.backgroundColor = .yellow
        } else if textField == verifyNumberTextField {
            verifyBottomLineView.backgroundColor = .yellow
        } else if textField == passwordTextField {
            
        } else if textField == passwordCheckTextField {
            
        }
        
    }
}
