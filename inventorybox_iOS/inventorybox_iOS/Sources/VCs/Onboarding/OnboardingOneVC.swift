//
//  OnboardingOneVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class OnboardingOneVC: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let isUser = UserDefaults.standard.bool(forKey: "onboarding")
        loadingView.isHidden = isUser ? false : true
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isUser = UserDefaults.standard.bool(forKey: "onboarding")
        print(isUser)
        if isUser {
            if let dvc = self.storyboard?.instantiateViewController(identifier: "LoginNC") {
 
                self.view.window?.rootViewController?.present(dvc, animated: false, completion: nil)
            }
        }
    }
    
}
