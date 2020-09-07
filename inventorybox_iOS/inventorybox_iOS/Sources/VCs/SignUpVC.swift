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
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var emailCheckLabel: UILabel!
    @IBOutlet var verifyCodeCheckLabel: UILabel!
    @IBOutlet var pwCheckLabel: UILabel!
    @IBOutlet var pwCheckAgainLabel: UILabel!
    @IBOutlet var emailTabImageView: UIImageView!
    @IBOutlet var verifyCodeTabImageView: UIImageView!
    @IBOutlet var pwTabImageView: UIImageView!
    @IBOutlet var pwCheckTabImageView: UIImageView!
    @IBOutlet var goToNextViewBtn: UIButton!
    
    var verifyCode:Int?
    var isVerify:Bool = false
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
    
    //인증하기에 +1, 인증번호 확인에+1, 비밀번호 확인에 +1해서 총 3이 되어야 다음 버튼 눌림
    var isComplete:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnOutlets()
        check()
        setviewLooklike()
        emailTextField.delegate = self
        verifiCodeTextField.delegate = self
        pwTextField.delegate = self
        pwConfirmTextField.delegate = self
        //        pwConfirmTextField.isSecureTextEntry = true
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func isValidPw(pw: String?) -> Bool {
        guard pw != nil else { return false }
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
    
    
    // 이메일 인증 눌렀을 떄
    @IBAction func certifyPressBtn(_ sender: Any) {
        
        // 서버 통신 코드
        emailAuthService.shared.getRecordEditIvPost(data: emailTextField.text!, completion: { networkResult in switch networkResult {
            
        case .success(let verify):
            guard let data = verify as? reciveData else {return}
            self.verifyCode = data.number
            print(self.verifyCode!)
            self.emailCheckLabel.text = "인증번호를 전송했습니다."
            self.emailCheckLabel.textColor = .yellow
            
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
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped() {
        appdelegate?.email = emailTextField.text!
        appdelegate?.password = pwTextField.text!
    }
    
    func setBtnOutlets(){
        verifyBtn.backgroundColor = .veryLightPinkTwo
        verifyBtn.layer.cornerRadius = 10
        confirmBtn.backgroundColor = .veryLightPinkTwo
        confirmBtn.layer.cornerRadius = 10
        verifyCodeCheckLabel.alpha = 0
        emailCheckLabel.alpha = 0
        pwCheckAgainLabel.alpha = 0
        verifyBtn.isEnabled = false
        confirmBtn.isEnabled = false
        goToNextViewBtn.isEnabled = false
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
    
    
    // email형식 확인
    @objc private func emailTextChecked(_ TextLabel: UILabel) {
        
        verifyBtn.backgroundColor = .charcoal
        verifyBtn.isEnabled = true
    }
    
    // 이메일 입력 텍스트 필드가 선택되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func emailTextFieldTapped(_ TextField : UITextField) {
        
        emailTabImageView.image = UIImage(named: "loginPwTextfield")
        emailCheckLabel.alpha = 0
        
    }
    
    // 이메일 입력 텍스트 필드가 선택 취소되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func emailTextFieldUnTapped(_ TextField : UITextField) {
        
        
        if (isValidEmail(id: emailTextField.text)){
            emailTabImageView.image = UIImage(named: "loginEmailTextfield")
        }
        else if(emailTextField.text == ""){
            emailTabImageView.image = UIImage(named: "loginEmailTextfield")
        }
        else {
            emailTabImageView.image = UIImage(named: "mypostShape")
        }
        
    }
    
    // 이메일 인증하기 코드가 보내졌을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func emailVerifyCodeSended(_ Button : UIButton) {
        
        if isValidEmail(id: emailTextField.text){
            emailTabImageView.image = UIImage(named: "loginEmailTextfield")
            emailCheckLabel.alpha = 1
            emailCheckLabel.text = "인증번호를 전송했습니다."
            emailCheckLabel.textColor = .yellow
            isComplete += 1
            print(isComplete)
        }
            
        else if (emailTextField.text == ""){
            emailCheckLabel.alpha = 0
        }
        else
        {
            emailCheckLabel.text = "☒올바른 이메일을 입력해주세요."
            emailTabImageView.image = UIImage(named: "mypostShape")
            emailCheckLabel.textColor = .red
            emailCheckLabel.alpha = 1
        }
    }
    
    // 인증번호 입력 텍스트 필드가 선택되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func verifyCodeTextFieldTapped(_ TextField : UITextField) {
        
        verifyCodeTabImageView.image = UIImage(named: "loginPwTextfield")
        verifyCodeCheckLabel.alpha = 0
        
    }
    
    // 이메일 입력 텍스트 필드가 선택 취소되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func verifyCodeTextFieldUnTapped(_ TextField : UITextField) {
        
        guard verifiCodeTextField.text != nil else { return }
        
        if (Int(verifiCodeTextField.text!) == verifyCode){
            verifyCodeTabImageView.image = UIImage(named: "loginEmailTextfield")
        }
        else if(verifiCodeTextField.text == ""){
            verifyCodeTabImageView.image = UIImage(named: "loginEmailTextfield")
        }
        else {
            verifyCodeTabImageView.image = UIImage(named: "mypostShape")
        }
        
    }
    
    //인증번호 입력 텍스트 필드가 수정될 때 스타일 변경해준다.
    @objc private func verifyCodeIsEntering(_ TextField: UITextField) {
        
        if (verifiCodeTextField.text == "") {
            confirmBtn.isEnabled = false
        }
        else {
            confirmBtn.isEnabled = true
            confirmBtn.backgroundColor = .charcoal
        }
    }
    
    
    // 인증번호 코드 확인을 눌렀을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func verifyCodeCorrectCheck(_ Button : UIButton) {
        
        guard verifiCodeTextField.text != nil else { return }
        
        if (Int(verifiCodeTextField.text!) == verifyCode){
            verifyCodeTabImageView.image = UIImage(named: "loginEmailTextfield")
            verifyCodeCheckLabel.alpha = 1
            verifyCodeCheckLabel.text = "이메일 인증이 완료되었습니다."
            verifyCodeCheckLabel.textColor = .yellow
            isComplete += 1
            print(isComplete)
        }
        else if(verifiCodeTextField.text == ""){
            verifyCodeTabImageView.image = UIImage(named: "loginEmailTextfield")
        }
        else {
            verifyCodeTabImageView.image = UIImage(named: "mypostShape")
            verifyCodeCheckLabel.alpha = 1
            verifyCodeCheckLabel.text = "☒인증번호가 일치하지 않습니다."
            verifyCodeCheckLabel.textColor = .red
        }
    }
    
    
    // 비밀번호 입력 텍스트 필드가 선택되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func pwTextFieldTapped(_ TextField : UITextField) {
        
        pwCheckLabel.text = "8~12자 이내의 문자,숫자,특수문자를 조합하여 입력해주세요."
        pwCheckLabel.textColor = .brownGrey
        pwTabImageView.image = UIImage(named: "loginPwTextfield")
    }
    
    // 비밀번호 입력 텍스트 필드가 선택 취소되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func pwTextFieldUnTapped(_ TextField : UITextField) {
        
        pwTabImageView.image = UIImage(named: "loginEmailTextfield")
        
    }
    
    
    // 비밀번호 확인 입력 텍스트 필드가 선택되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func pwCheckTextFieldTapped(_ TextField : UITextField) {
        
        
        if !isValidPw(pw: pwTextField.text){
            pwCheckLabel.text = "☒8~12자 이내의 문자,숫자,특수문자를 조합하여 입력해주세요."
            pwTabImageView.image = UIImage(named: "mypostShape")
            pwCheckLabel.textColor = .red
            pwCheckLabel.alpha = 1
        }
            
        else
        {
            pwCheckTabImageView.image = UIImage(named: "loginPwTextfield")
            pwCheckLabel.alpha = 0
            pwCheckAgainLabel.alpha = 0
        }
    }
    
    @objc private func pwCheckTextFieldEditing(_ TextField : UITextField) {
        
        if (pwTextField.text != pwConfirmTextField.text) {
            pwCheckAgainLabel.alpha = 1
            pwCheckAgainLabel.text = "☒입력하신 비밀번호와 일치하지 않습니다."
            pwCheckTabImageView.image = UIImage(named: "mypostShape")
            pwCheckAgainLabel.textColor = .red
        }
        else {
            pwCheckAgainLabel.alpha = 0
            pwCheckTabImageView.image = UIImage(named: "loginEmailTextfield")
            isComplete += 1
            if isComplete == 3 {
                goToNextViewBtn.isEnabled = true
            }
        }
        
    }
    
    // 비밀번호 확인 입력 텍스트 필드가 선택 취소되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func pwCheckTextFieldUnTapped(_ TextField : UITextField) {
        
        pwCheckTabImageView.image = UIImage(named: "loginEmailTextfield")
        
        
    }
    
}

extension SignUpVC {
    
    private func setviewLooklike(){
        /* 선택했을때 텍스트 필드 디자인을 바꿔주는 역할을 하는 코드.
         textFieldTapped(_:) 라는 함수를 class 안에 선언해줘야 동작을 한다.
         .editingDidBegin 는 텍스트 필드가 선택되었을 때 실행한다는 것 */
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldTapped(_:)), for: .editingDidBegin)
        
        /* 선택을 풀었을때 텍스트 필드 디자인을 바꿔주는 역할을 하는 코드.
         textFieldTapped(_:) 라는 함수를 class 안에 선언해줘야 동작을 한다.
         .editingDidBegin 는 텍스트 필드가 선택되었을 때 실행한다는 것*/
        emailTextField.addTarget(self, action: #selector(emailTextFieldUnTapped(_:)), for: .editingDidEnd)
        
        verifyBtn.addTarget(self, action: #selector(emailVerifyCodeSended(_:)), for: .touchUpInside)
        
        verifiCodeTextField.addTarget(self, action: #selector(verifyCodeTextFieldTapped), for: .editingDidBegin)
        
        verifiCodeTextField.addTarget(self, action: #selector(verifyCodeTextFieldUnTapped), for: .editingDidEnd)
        
        confirmBtn.addTarget(self, action: #selector(verifyCodeCorrectCheck(_:)), for: .touchUpInside)
        
        pwTextField.addTarget(self, action:
            #selector(pwTextFieldTapped(_:)), for: .editingDidBegin)
        
        pwTextField.addTarget(self, action: #selector(pwTextFieldUnTapped(_:)), for: .editingDidEnd)
        
        pwConfirmTextField.addTarget(self, action:
            #selector(pwCheckTextFieldTapped(_:)), for: .editingDidBegin)
        
        pwConfirmTextField.addTarget(self, action: #selector(pwCheckTextFieldUnTapped(_:)), for: .editingDidEnd)
    }
    
    private func check(){
        emailTextField.addTarget(self, action: #selector(emailTextChecked(_:)), for: .editingChanged)
        
        verifiCodeTextField.addTarget(self, action: #selector(verifyCodeIsEntering(_:)), for: .editingChanged)
        
        pwConfirmTextField.addTarget(self, action: #selector(pwCheckTextFieldEditing(_:)), for: .editingChanged)
    }
    
}
