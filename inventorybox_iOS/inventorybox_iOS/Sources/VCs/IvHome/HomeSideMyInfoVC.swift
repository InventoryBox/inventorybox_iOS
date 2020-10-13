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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameTextField.delegate = self
        storeNameTextField.delegate = self
        locationTextField.delegate = self
        phoneTextField.delegate = self
        
        nameTextField.makeBorder(color: .pinkishGrey)
        storeNameTextField.makeBorder(color: .pinkishGrey)
        locationTextField.makeBorder(color: .pinkishGrey)
        phoneTextField.makeBorder(color: .pinkishGrey)
        
    }
    
    func getDataFromServer(){
        
        IvHomeHamburgerPrivateInformationService.shared.getprivateInformation(completion:  { networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? PrivateInformationData else { return }
                
                self.nameTextField.text = dt.result[0].repName
                self.storeNameTextField.text = dt.result[0].coName
                self.phoneTextField.text = dt.result[0].phoneNumber
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
            } })
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
        textField.makeBorder(color: .gray)
    }
}

extension UITextField {
    func makeBorder(color: UIColor) {
        self.layer.cornerRadius = self.frame.height / 5
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
}
