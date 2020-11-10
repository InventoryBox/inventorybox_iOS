//
//  LogOutPopUpVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class LogOutPopUpVC: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        lineView.backgroundColor = .veryLightPinkTwo
        
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("popup"), object: nil)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func loggingOut(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
        print("자동로그인 삭제")
        
        NotificationCenter.default.post(name: .init("logout"), object: nil)
       
    }
}
