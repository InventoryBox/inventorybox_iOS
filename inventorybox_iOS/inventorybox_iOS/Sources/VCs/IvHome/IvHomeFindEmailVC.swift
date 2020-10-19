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
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
  
    var repname: String?
    var coname : String?
    var phonenumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
    }
    func setOutlets(){
        repNameTx.delegate = self
        coNameTx.delegate = self
        phoneNumberTx.delegate = self
    }
    
    @IBAction func profileChangePressBtn(_ sender: Any) {
        appdelegate?.repName = repNameTx.text!
        appdelegate?.coName = coNameTx.text!
        appdelegate?.phoneNumber = phoneNumberTx.text!
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
    
    
}





// MARK: 비밀번조 재설정 관련 VC
class FindPasswordVC : UIViewController{
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var verifiCodeTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwConfirmTextField: UITextField!
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet var emailCheckLabel: UILabel!
    @IBOutlet var verifyCodeCheckLabel: UILabel!
    @IBOutlet var pwCheckLabel: UILabel!
    @IBOutlet var pwCheckAgainLabel: UILabel!
    @IBOutlet var emailTabView: UIView!
    @IBOutlet var verifyCodeTabView: UIView!
    @IBOutlet var pwTabView: UIView!
    @IBOutlet var pwCheckTabView: UIView!
    @IBOutlet var goToFinishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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


