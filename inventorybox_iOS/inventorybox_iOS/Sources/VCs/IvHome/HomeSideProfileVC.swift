//
//  HomeSideProfileVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeSideProfileVC: UIViewController {

    @IBOutlet weak var nameReset: UITextField!
    
    var name : String?  // 원래 이름 받아서 보여주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastName()

        // Do any additional setup after loading the view.
    }
    
    // 연하게 원래 이름 보여주기
    func pastName(){
        nameReset.placeholder = name
    }

    // 이름 저장하기
    @IBAction func saveNameAction(_ sender: Any) {
        
    }
    
    
    
    // 뒤로가기 버튼
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

}
