//
//  SideMenuVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnClickBack(_ sender: Any) {
        
        NotificationCenter.default.post(name: .init("popup"), object: nil)
        self.dismiss(animated: true, completion: nil)
          // 로그인 화면으로 돌아가기 위해!!
    }
    

 
}
