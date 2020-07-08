//
//  SelectIconVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SelectIconVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func sendIdx(_ sender: UIButton) {
        guard let idx = sender.currentTitle else {
            return
        }
        NotificationCenter.default.post(name: .init("iconIdx"), object: nil, userInfo: ["selectedIdx": idx])
        self.dismiss(animated: true)
    }
}
