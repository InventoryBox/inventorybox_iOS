//
//  SideBarMenuAlramVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SideBarMenuAlramVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func alarmBackPressBtn(_ sender: Any) {

//        self.navigationController?.popViewController(animated: true)


        self.dismiss(animated: true, completion: nil)
             // 로그인 화면으로 돌아가기 위해!!
    }
    

}
