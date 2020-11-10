//
//  LoginVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var idCheck : Int = 0
    var pwCheck : Int = 0
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var autoLoginCheckBox: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loginBtn.isEnabled = false
        super.viewDidLoad()
        signUpBtn.layer.cornerRadius = 2
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addLeftPadding()
        passwordTextField.addLeftPadding()
        loginBtn.layer.cornerRadius = 18
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        autoLogin()
    }
    
    
    func autoLogin(){
        
        if let userid = UserDefaults.standard.string(forKey: "id") {
            if let pw = UserDefaults.standard.string(forKey: "pw") {
            //로그인 통신 함수
                LoginService.shared.login(id: userid, pw: pw) { result in
                    switch result {
                    case .success(let jwt):
                        guard let token = jwt as? String else {
                            return
                        }
                        UserDefaults.standard.set(token, forKey: "token")
                        let mainST = UIStoryboard.init(name: "Main", bundle: nil)
                        guard let mainTabVC = mainST.instantiateViewController(identifier: "TabBarVC") as? TabBarVC  else { return }
                        mainTabVC.modalPresentationStyle = .fullScreen
                        self.present(mainTabVC, animated: true, completion: nil)
                        print("autoLogin")
                        print(token)
                    case .requestErr(let msg):
                        let alert = UIAlertController(title: "로그인 실패", message: msg as! String, preferredStyle: UIAlertController.Style.alert)
                        let Action = UIAlertAction(title: "OK", style: .default, handler : nil)
                        alert.addAction(Action)
                        print("server")
                    case .pathErr:
                        print("path")
                        break
                    case .serverErr:
                        print("server")
                        break
                    case .networkFail:
                        print("network")
                        break
                    }
                }
            }
        }

    }
    
    
    @IBAction func doLogin(_ sender: UIButton) {
        //로그인하기
        
        guard let id = self.emailTextField.text else {return}
        guard let pw = self.passwordTextField.text else {return}
        
        if self.autoLoginCheckBox.on {
            UserDefaults.standard.set(id, forKey: "id")
            UserDefaults.standard.set(pw, forKey: "pw")
        }

        
        LoginService.shared.login(id: self.emailTextField.text!, pw: self.passwordTextField.text!) { result in
            switch result {
            case .success(let jwt):
                guard let token = jwt as? String else {
                    return
                }
                UserDefaults.standard.set(token, forKey: "token")
                let mainST = UIStoryboard.init(name: "Main", bundle: nil)
                guard let mainTabVC = mainST.instantiateViewController(identifier: "TabBarVC") as? TabBarVC  else { return }
                mainTabVC.modalPresentationStyle = .fullScreen
                self.present(mainTabVC, animated: true, completion: nil)
                print("성공")
                print(token)
            case .requestErr(let msg):
                let alert = UIAlertController(title: "로그인 실패", message: msg as! String, preferredStyle: UIAlertController.Style.alert)
                let Action = UIAlertAction(title: "OK", style: .default, handler : nil)
                alert.addAction(Action)
                print("server")
            case .pathErr:
                print("path")
                break
            case .serverErr:
                print("server")
                break
            case .networkFail:
                print("network")
                break
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
        
    }
    
      
}


//txtFields[1].isSecureTextEntry = true 값 비밀로 받기!



