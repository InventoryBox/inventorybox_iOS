//
//  IvHomeFindEmailVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/19.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvHomeFindEmailVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    // 이메일 찾기 관련
    @IBOutlet weak var findEmailTabBar: UIButton!       // 이메일 찾기
    @IBOutlet weak var findEmailLineView: UIView!       // 노란색 선
    // 비밀번호 수정하기 관련
    @IBOutlet weak var findPasswordTabBar: UIButton!    // 비밀번호 재설정
    @IBOutlet weak var findPasswordLineView: UIView!    // 노란색
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcontrollerSetting()
    }

    // MARK: 탭바를 통한 화면 전환하기
     func viewcontrollerSetting(){
        self.scrollView.contentSize.width = self.view.frame.width * 2
         // FindEmailVC 생성
         guard let leftVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FindEmailVC.self)) as? FindEmailVC else { return }
         // FindEmailVC를 Child View Controller로 지정
         self.addChild(leftVC)
         // FindEmailVC의 View만 가져오기
         guard let leftVCView = leftVC.view else { return }
         // FindEmailVC View의 Frame 지정
         leftVCView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
         // Scroll View에 FindEmailVC의 View 넣기
         self.scrollView.addSubview(leftVCView)
         // 이제 FindEmailVC가 Container View Controller 앞으로 올라왔기 때문에 didmove(toParent:)를 실행
         leftVC.didMove(toParent: self)
         
         // FindPasswordVCr도 동일.
         guard let rightVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FindPasswordVC.self)) as? FindPasswordVC else { return }
         self.addChild(rightVC)
         guard let rightVCView = rightVC.view else { return }
         rightVCView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
         self.scrollView.addSubview(rightVCView)
         rightVC.didMove(toParent: self)
    }
    // 뒤로가기 버튼
    @IBAction func backNavigationPressBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 이메일 찾기 View 버튼
    @IBAction func findEmailPressBtn(_ sender: Any) {
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        findEmailLineView.backgroundColor = .yellow
        findPasswordLineView.backgroundColor = .gray
    }
    
    // MARK: 비밀번호 재설정 View 버튼
    @IBAction func findPasswordPressBtn(_ sender: Any) {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width, y: 0), animated: true)
        findEmailLineView.backgroundColor = .gray
        findPasswordLineView.backgroundColor = .yellow
    }
}


// MARK: 이메일 찾기 관련 VC
class FindEmailVC : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var repNameTx: UITextField!      // 사업자명
    @IBOutlet weak var coNameTx: UITextField!       // 가게명
    @IBOutlet weak var phoneNumberTx: UITextField!  // 연락처
    @IBOutlet weak var profileChangeBtn: UIButton!  // 비밀번호 재설정 하기 버튼
    @IBOutlet weak var useEmailLabel: UILabel!
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
  
    var repname: String?
    var coname : String?
    var phonenumber : String?
    var reciveEmail : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
        profileChangeBtn.isEnabled = false
    }
    func setOutlets(){
        repNameTx.delegate = self
        coNameTx.delegate = self
        phoneNumberTx.delegate = self
    }
    
    // 사업자명, 가게명, 연락처를 맞췄을 때
    @IBAction func profileChangePressBtn(_ sender: Any) {
        
        print(repNameTx.text!)
        print(coNameTx.text!)
        
        var phoneNum = "";
        if let phoneNumber = phoneNumberTx.text {
            let phoneArray = phoneNumber.components(separatedBy: "-")
            
            for i in phoneArray {
                phoneNum += i
            }
        }
        print(phoneNum)
        FindEmailService.shared.findEmailPost(repName: repNameTx.text!, coName: coNameTx.text!, phone: phoneNum, completion: { networkResult in switch networkResult {
        
        case .success(let verify):
            
            guard let data = verify as? reciveEmailData else {return}
            self.reciveEmail = data.email
            self.useEmailLabel.text = self.reciveEmail
            self.useEmailLabel.textColor = .yellow
            print(self.reciveEmail!)
            
        case .requestErr(let message):
            guard let message = message as? String else { return }
            print(message)
            
        case .pathErr:
            self.useEmailLabel.text = "없는 사용자입니다."
            self.useEmailLabel.textColor = .red
            print("path")
        case .serverErr: print("serverErr")
        case .networkFail: print("networkFail")
        }})
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.repNameTx {
            textField.resignFirstResponder()
            self.coNameTx.becomeFirstResponder()
        }
        else if textField == self.coNameTx {
            textField.resignFirstResponder()
            self.phoneNumberTx.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func format(with mask: String, phone: String) -> String {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneNumberTx {
            var strText: String? = textField.text
                   if strText == nil {
                       strText = ""
                   }
                   let newString = (strText! as NSString).replacingCharacters(in: range, with: string)
                   
                   textField.text = format(with: "XXX-XXXX-XXXX", phone: newString)
                   return false
        }
        if (repNameTx.text != "") && (coNameTx.text != "") && (phoneNumberTx.text != ""){
            profileChangeBtn.isEnabled = true
              }
       return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (repNameTx.text != "") && (coNameTx.text != "") && (phoneNumberTx.text != ""){
            profileChangeBtn.isEnabled = true
        } else {
            profileChangeBtn.isEnabled = false
        }
    }
    
    
}




// MARK: 비밀번조 재설정 관련 VC
class FindPasswordVC : UIViewController, UITextFieldDelegate{
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var verifiCodeTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwConfirmTextField: UITextField!
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet var emailCheckLabel: UILabel!
    @IBOutlet var verifyCodeCheckLabel: UILabel!
    @IBOutlet var pwCheckLabel: UILabel!
    @IBOutlet var pwCheckAgainLabel: UILabel!
    @IBOutlet weak var emailTabImageView: UIImageView!
    @IBOutlet weak var verifyCodeTabImageView: UIImageView!
    @IBOutlet weak var pwTabImageView: UIImageView!
    @IBOutlet weak var pwCheckTabImageView: UIImageView!
    @IBOutlet var goToFinishBtn: UIButton!
    @IBOutlet weak var paswordView: UIView!
    @IBOutlet weak var savePasswordBtn: UIButton!
    
    var verifyCode:Int?
    var isVerify:Bool = false
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
    var password: String?
    
//    var verifyNumber: Int?
//    var isChecked: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnOutlets()
        check()
        setviewLooklike()
        paswordView.isHidden = true
        emailTextField.delegate = self
        verifiCodeTextField.delegate = self
        pwTextField.delegate = self
        pwConfirmTextField.delegate = self
        goToFinishBtn.isEnabled = false
        
        pwTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        pwConfirmTextField.addTarget(self, action: #selector(passwordCheckTextFieldDidChange), for: .editingChanged)
    }
    // 비밀번호 변경
    @objc private func passwordTextFieldDidChange() {
        if let t = pwTextField.text {
            if isValidPw(pw: t) {
                password = t
            } else {
            }
        }
    }
    // 비밀번호 변경 재입력
    @objc private func passwordCheckTextFieldDidChange() {
        if let pw = password, let t = pwConfirmTextField.text {
            if pw == t {
            } else {
            }
        }
    }
    
 
    
    // 인증하기 버튼
    @IBAction func certifyPressBtn(_ sender: Any) {
        // 서버 통신 코드
        FindEmailCheckService.shared.emailCheckPost(data: emailTextField.text!, completion: { networkResult in switch networkResult {
            
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
    
    // 인증번호 확인하기 버튼
    @IBAction func compareBtn(_ sender: Any) {
        
        if Int(verifiCodeTextField.text!) == verifyCode {
            print("인증이 완료되었습니다.")
            // print(isVerify)
            paswordView.isHidden = false
            isVerify = true
        }
        else {
            print("인증번호가 일치하지 않습니다.")
        }
        
    }
    
    // 비밀번호 변경
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        if let pw = password {
            PasswordChangePutService.shared.changePassword(password: pw) { (networkResult) in
                switch networkResult {
                case .success(let data):
                    print(data)
                    
                    print("비밀번호가 재설정 되었습니다.")
                  
                    // Alert 만들기
                    let alert = UIAlertController(title: "비밀번호 재설정", message: "비밀번호가 재설정 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                    let yes = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(yes)
                    self.present(alert, animated: true, completion: nil)
                    
                    self.navigationController?.popViewController(animated: true)
                    self.emailTextField.text = ""
                    self.verifiCodeTextField.text = ""
                    self.pwTextField.text = ""
                    self.pwConfirmTextField.text = ""
                    self.paswordView.isHidden = true
                    
                    print()
    
                case .requestErr(let message):
                    guard let message = message as? String else { return }
                    print(message)
                    
                case .pathErr: print("path")
                case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
                }
            }
        }
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
        savePasswordBtn.imageView?.image = UIImage(named: "btnChangeSaveBefore")
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
      
            goToFinishBtn.isEnabled = true
            
            savePasswordBtn.imageView?.image = UIImage(named: "btnChangeSaveAfter")
        }
        
    }
    
    // 비밀번호 확인 입력 텍스트 필드가 선택 취소되었을 때 텍스트 필드의 스타일을 변경시켜준다.
    @objc private func pwCheckTextFieldUnTapped(_ TextField : UITextField) {
        
        pwCheckTabImageView.image = UIImage(named: "loginEmailTextfield")
        
        
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
    
}

extension FindPasswordVC {
    
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



