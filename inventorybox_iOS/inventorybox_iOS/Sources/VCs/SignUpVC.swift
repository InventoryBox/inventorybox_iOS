//
//  SignUpVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit


class SignUpVC: UIViewController,UITextFieldDelegate {

   


    @IBOutlet var signUpNavigationView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var verifiCodeTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwConfirmTextField: UITextField!
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    var verifyCode:Int?
    var isVerify:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBtnOutlets()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
  
    
    
    // 이메일 인증 눌렀을 떄
    @IBAction func certifyPressBtn(_ sender: Any) {
        
        //        print(orderCheckMemoInformations)
        // 서버 통신 코드
        emailAuthService.shared.getRecordEditIvPost(data: emailTextField.text!, completion: { networkResult in switch networkResult {
            
        case .success(let verify):
            guard let data = verify as? reciveData else {return}
            self.verifyCode = data.number
            print(self.verifyCode)
            
        case .requestErr(let message):
            guard let message = message as? String else { return }
            print(message)
            
        case .pathErr: print("path")
        case .serverErr: print("serverErr")
        case .networkFail: print("networkFail")
            }
        }
        )
    }
    
        
    //keyboard Action
    
    @objc func keyboardWillShow(_ sender: Notification) {
         self.view.frame.origin.y = -80 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            textField.resignFirstResponder()
            self.verifiCodeTextField.becomeFirstResponder()
        }
        else if textField == self.verifiCodeTextField {
            textField.resignFirstResponder()
            self.pwTextField.becomeFirstResponder()
        }
        else if textField == self.pwTextField {
            textField.resignFirstResponder()
            self.pwConfirmTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func compareBtn(_ sender: UIButton) {
        if Int(verifiCodeTextField.text!) == verifyCode {
            print("인증이 완료되었습니다.")
            print(isVerify)
            isVerify = true
        }
        else {
            print("인증번호가 일치하지 않습니다.")
        }
    }
    
    func setBtnOutlets(){
        verifyBtn.layer.cornerRadius = 10
        confirmBtn.layer.cornerRadius = 10
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //    func setTextField() {
    //        if emailTextField.text == "" {
    //
    //        }
    //        else if isVerify == false {
    //
    //        }
    //        else if pwTextField.text == "" {
    //
    //        }
    //        else if pwConfirmTextField.text == "" {
    //
    //        }
    //        else {
    //            confirmBtn.isEnabled = true
    //        }
    //    }
    //
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
