//
//  PersonalInfoChangeVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/08/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class PersonalInfoChangeVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var repNameTextField: UITextField!
    @IBOutlet var coNameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var goToProfileBtn: UIButton!
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveData() {
        appdelegate?.repName = repNameTextField.text!
        appdelegate?.coName = coNameTextField.text!
        appdelegate?.phoneNumber = phoneNumberTextField.text!
    }
    
    func setOutlets(){
        repNameTextField.delegate = self
        coNameTextField.delegate = self
        phoneNumberTextField.delegate = self
//        goToProfileBtn.isEnabled = false
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.repNameTextField {
            textField.resignFirstResponder()
            self.coNameTextField.becomeFirstResponder()
        }
            
        else if textField == self.coNameTextField {
            textField.resignFirstResponder()
            self.phoneNumberTextField.becomeFirstResponder()
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
        
        if textField == phoneNumberTextField {
            var strText: String? = textField.text
                   if strText == nil {
                       strText = ""
                   }
                   let newString = (strText! as NSString).replacingCharacters(in: range, with: string)
                   
                   textField.text = format(with: "XXX-XXXX-XXXX", phone: newString)
                   return false
        }
        if (repNameTextField.text != "") && (coNameTextField.text != "") && (phoneNumberTextField.text != ""){
                  goToProfileBtn.isEnabled = true
              }
       return true
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

extension PersonalInfoChangeVC {
    
    
}

