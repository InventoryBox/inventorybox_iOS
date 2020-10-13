//
//  UserOutPopUpVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class UserOutPopUpVC: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var outButten: UIButton!
    @IBOutlet weak var lineView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineView.backgroundColor = .veryLightPinkTwo
        
        outButten.layer.cornerRadius = outButten.frame.height / 2
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        
    }
    @IBAction private func cancel(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("popup"), object: nil)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func userOut(_ sender: UIButton) {
        UserDeleteService.shared.deleteUser { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? String else { return }
                print(dt)
                NotificationCenter.default.post(name: .init("logout"), object: nil)
                
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
