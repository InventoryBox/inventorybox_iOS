//
//  OnboardingTwoVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class OnboardingTwoVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
}
