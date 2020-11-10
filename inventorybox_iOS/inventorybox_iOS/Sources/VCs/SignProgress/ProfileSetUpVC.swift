//
//  ProfileSetUpVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/08/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class ProfileSetUpVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var profileImage: UIButton!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var goToNextBtn: UIButton!
    @IBOutlet var nicknameCheckLabel: UILabel!
    var profileImg:UIImage?
    var profileImgName:String = ""
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
    var nicknameCheck:Bool?
    var isImage: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        nickNameTextField.delegate = self
        
    }
    
    func setOutlets(){
        nickNameTextField.addLeftPadding2()
        nicknameCheckLabel.text = ""
        goToNextBtn.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func setMyProfile() {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            profileImgName = url.lastPathComponent
            profileImg = image
            self.profileImage.setImage(profileImg, for: .normal)
            isImage = true
            if nickNameTextField.text != "" {
                goToNextBtn.isEnabled = true
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) { self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveData() {
        appdelegate?.imgName = profileImgName
        appdelegate?.img = profileImg!
         //닉네임 중복 api붙이기
        NicknameOverlapCheckService.shared.nicknameCheck(self.nickNameTextField.text!){ result in
            switch result {
            case .success:
                self.nicknameCheckLabel.text = ""
                self.nickNameTextField.layer.borderWidth = 0
                self.appdelegate?.nickName = self.nickNameTextField.text
                let agreementVC = self.storyboard?.instantiateViewController(identifier: "AgreementVC") as? AgreementVC
                self.navigationController?.pushViewController(agreementVC!, animated: true)
            case .requestErr(let msg):
                self.nicknameCheckLabel.text = "이미 사용중인 닉네임입니다."
                self.nicknameCheckLabel.textColor = .red
                let myColor : UIColor = UIColor( red: 1, green: 0, blue:0, alpha: 1.0 )
                self.nickNameTextField.layer.borderWidth = 1.5
                self.nickNameTextField.layer.cornerRadius = 8
                self.nickNameTextField.layer.borderColor = myColor.cgColor
                print(msg)
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
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension ProfileSetUpVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nickNameTextField.text != "" && isImage == true {
            goToNextBtn.isEnabled = true
        } else {
            goToNextBtn.isEnabled = false
        }
        
    }
}
