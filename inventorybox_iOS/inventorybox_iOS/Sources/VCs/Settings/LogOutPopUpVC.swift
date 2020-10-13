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
        
        logoutButton.layer.cornerRadius = 25
        cancelButton.layer.cornerRadius = 25
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func loggingOut(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .init("logout"), object: nil)
        
    }
}
