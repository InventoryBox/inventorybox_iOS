//
//  LoginVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var idCheck : Int = 0
    var pwCheck : Int = 0

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailCheckLabel: UILabel!
    @IBOutlet var passwordCheckLabel: UILabel!
    @IBOutlet var emailCheckImg: UIImageView!
    @IBOutlet var passwordCheckImg: UIImageView!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loginBtn.isEnabled = false
        super.viewDidLoad()
        signUpBtn.layer.cornerRadius = 2
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addLeftPadding()
        passwordTextField.addLeftPadding()
        loginCheck()
        setviewLooklike()
        loginBtn.layer.cornerRadius = 18
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        //로그인하기
        
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
   
    @IBAction func idCheckButton(_ sender: Any) {
        idCheck = 1
    }
    @IBAction func pwCheck(_ sender: Any) {
        pwCheck = 1
    }
    
        
        
        func isValidId(id: String?) -> Bool {
            guard id != nil else { return false }
            //받아오는 id값이 비어있으면 안되겠쥬?
            let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            // 이메일 정규표현식
            let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
            //NSPredicate는 검색 조건을 텍스트로 입력하여 검색할 수 있게하는거라구 한다..SQL문이라
            // 너무 자세하게하면 어렵다구한다..
            // %@는 하나의 객체로 치환해주는 역할을 함.
            return pred.evaluate(with: id)
            // id 값이 pred의 값과 일치하는지 않하는지 여부를 판단해줌
            // 결과값이 true false로 나옴
        }
        
        func isValidPw(pw: String?) -> Bool {
            guard pw != nil else { return false }
            //받아오는 pw값이 비어있으면 안되겠쥬?
            // let regEx = "[A-Za-z0-9]{8,12}"
            // 8~12자 영어,숫자 제한 정규표현식
            let regEx = "^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,12}$"
            // 8~12자 특수문자 조합 정규표현식
            let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
            //NSPredicate는 검색 조건을 텍스트로 입력하여 검색할 수 있게하는거라구 한다..SQL문이라
            // 너무 자세하게하면 어렵다구한다..
            // %@는 하나의 객체로 치환해주는 역할을 함.
            return pred.evaluate(with: pw)
            // id 값이 pred의 값과 일치하는지 않하는지 여부를 판단해줌
            // 결과값이 true false로 나옴
        }
        
        
        
        /* 텍스트 필드가 선택되었을 때 텍스트 필드의 스타일을 변경시켜준다.
         */
        
        /* 텍스트 필드가 선택 취소되었을 때 텍스트 필드의 스타일을 변경시켜준다.
         */
        
        /* id와 pw를 비교해주어서 다를 경우에는 텍스트 필드를 빨갛게 처리해준다.
         값이 같으면 다시 원래대로 돌아옴*/
    
        @objc private func textFieldcompare(_ TextField: UITextField) {
            
            if ( emailTextField.text == passwordTextField.text ){
            }
            else
            {
                passwordTextField.backgroundColor = UIColor.white
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.borderWidth = 1
                
                passwordTextField.backgroundColor = UIColor.white
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.borderWidth = 1
            }
        }
        
        // id형식 확인
        @objc private func idTextChecked(_ TextLabel: UILabel) {
            
//            if ( isValidId(id: emailTextField.text)){
//                emailCheckLabel.text = "id 조건 확인하세요"
//                emailCheckLabel.alpha = 1
//            }
//            else
//            {
//                emailCheckLabel.text = "id 조건 확인하세요"
//                emailCheckLabel.alpha = 0
//            }
        }
        
    }


    extension LoginVC {
        //extension으로 텍스트 필드 선택했을때 하는 작업들을 함수로 빼준다.
        private func setviewLooklike(){
            /* 선택했을때 텍스트 필드 디자인을 바꿔주는 역할을 하는 코드.
             textFieldTapped(_:) 라는 함수를 class 안에 선언해줘야 동작을 한다.
             .editingDidBegin 는 텍스트 필드가 선택되었을 때 실행한다는 것*/
         
            
            
            /* 선택을 풀었을때 텍스트 필드 디자인을 바꿔주는 역할을 하는 코드.
             textFieldTapped(_:) 라는 함수를 class 안에 선언해줘야 동작을 한다.
             .editingDidBegin 는 텍스트 필드가 선택되었을 때 실행한다는 것*/
          
            
            /* 두 텍스트 필드를 비교해서 텍스필드 디자인을 바꿔주는 역할을 하는 코드.
             textFieldcompare(_:) 라는 함수를 class 안에 선언해줘야 동작을 한다.
             .editingChanged 는 텍스트 필드의 값이 바뀔때마다 실행*/
            passwordTextField.addTarget(self, action: #selector(textFieldcompare(_:)), for: .editingChanged)
        }
        
        
        private func loginCheck(){
            emailTextField.addTarget(self, action: #selector(idTextChecked(_:)), for: .editingChanged)
            
        }
        
    }


    //txtFields[1].isSecureTextEntry = true 값 비밀로 받기!



