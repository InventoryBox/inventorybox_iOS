//
//  HomeSideProfileVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeSideProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    var nickName: String? = nil
    var profileImage: UIImage? = UIImage.init(named: "imgProfile")
    var profileImageName: String? = "imgProfile"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IvHomeHamburgerProfileService.shared.getProfile { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? ProfileData else { return }
                self.nickNameTextField.text = dt.nickname
                let url = URL(string: dt.img)
                self.profileImageView.kf.setImage(with: url)
                
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = nickName {
            nickNameTextField.text = name
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        if let profile = profileImage {
            self.profileImageView.image = profile
        }
        
    }
    
    @IBAction func changeProfileImage(_ sender: UIButton) {
        
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            profileImageName = url.lastPathComponent
            self.profileImageView.image = image
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) { self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProfile(_ sender: Any) {
        guard let nickName = nickNameTextField.text else {
            return
        }
        
        guard let profileImg = profileImageView.image else { return }
        
        guard let imgName = profileImageName else { return }
        
        print(nickName)
        print(profileImg)
        print(imgName)
        IvHomeHamburgerProfilePutService.shared.changeProfile(nickname: nickName, img: profileImg, imgName: imgName) { networkResult in
            switch networkResult{
            case .success:
                print("success")
                self.dismiss(animated: true, completion: nil)
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
