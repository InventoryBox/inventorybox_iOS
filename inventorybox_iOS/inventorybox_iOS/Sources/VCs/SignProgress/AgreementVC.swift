//
//  AgreementVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/08/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox

class AgreementVC: UIViewController {

    @IBOutlet var entireAgreeCheckBox: BEMCheckBox!
    @IBOutlet var termsAgreeCheckBox: BEMCheckBox!
    @IBOutlet var personalInfoCheckBox: BEMCheckBox!
    @IBOutlet var locationInfoAgreeCheckBox: BEMCheckBox!
    @IBOutlet var marketingAgreeCheckBox: BEMCheckBox!
    var appdelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
        // Do any additional setup after loading the view.
    }
    
    func setOutlets(){
        entireAgreeCheckBox.on = false
        termsAgreeCheckBox.on = false
        personalInfoCheckBox.on = false
        locationInfoAgreeCheckBox.on = false
        marketingAgreeCheckBox.on = false
    }
    @IBAction func entireAgreement(_ sender: BEMCheckBox) {
        termsAgreeCheckBox.on = true
        personalInfoCheckBox.on = true
        locationInfoAgreeCheckBox.on = true
        marketingAgreeCheckBox.on = true
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func doSignUpBtn() {
        if (marketingAgreeCheckBox.on == true) {
            appdelegate?.pushAlarm = 1
        }
        else {
            appdelegate?.pushAlarm = 0
        }
        
        //회원가입 API 붙이기
        
        SignUpService.shared.signup(email: (appdelegate?.email)!, password: (appdelegate?.password)!, nickname: (appdelegate?.nickName)!, repName: (appdelegate?.repName)!, coName: (appdelegate?.coName)!, phoneNumber: (appdelegate?.phoneNumber)!, pushAlarm: (appdelegate?.pushAlarm)!, img: (appdelegate?.img)!, imgName: (appdelegate?.imgName)!, completion: {
            networkResult in
                switch networkResult{
                case .success:
                    print("success")
                    self.navigationController?.popToRootViewController(animated: true)
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
            })
            
    }
}
