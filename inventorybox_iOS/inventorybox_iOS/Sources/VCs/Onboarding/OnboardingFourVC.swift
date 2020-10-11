//
//  OnboardingFourVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class OnboardingFourVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func startInventoryApp(_ sender: UIButton) {
        
        if let dvc = self.storyboard?.instantiateViewController(identifier: "LoginNC") {
            
            UserDefaults.standard.set(true, forKey: "onboarding")
            self.present(dvc, animated: true, completion: nil)
        }
        
    }
}
