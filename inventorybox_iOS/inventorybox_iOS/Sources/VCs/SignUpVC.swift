//
//  SignUpVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit


class SignUpVC: UIViewController,UITextFieldDelegate {

   

    @IBOutlet var signUpFirstProgressBar: UIProgressView!
    @IBOutlet var signUpNavigationView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var verifiCodeTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwConfirmTextField: UITextField!
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController?.navigationBar.isHidden = false
       // self.navigationItem.title = "회원가입"
        
        signUpFirstProgressBar.progress = 1
        completeBtn.isEnabled = false
        setBtnOutlets()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
  
    
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
    

    func setTextField(){
        if emailTextField.text == "" {
           
        }
        else if verifiCodeTextField.text == "" {
            
        }
    }
    
    func setBtnOutlets(){
        verifyBtn.layer.cornerRadius = 10
        confirmBtn.layer.cornerRadius = 10
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
