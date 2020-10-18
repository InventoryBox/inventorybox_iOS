//
//  SettingDetailVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/09/20.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SettingDetailVC: UIViewController {
    static let identifier: String = "SettingDetailVC"
    
    var navigationTitle: String?
    var whichInformation: Int?
    
    @IBOutlet weak var userTermScrollView: UIScrollView!
    @IBOutlet weak var privacyPolicyScrollView: UIScrollView!
    @IBOutlet weak var locationTermScrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        //출처: https://zeddios.tistory.com/29 [ZeddiOS]
        
        self.navigationController?.navigationBar.isHidden = false
        if let indexPath = whichInformation {
            showInformation(by: indexPath)
        }
        
    }
    
    private func showInformation(by indexPath: Int) {
        userTermScrollView.isHidden = indexPath == 0 ? false : true
        privacyPolicyScrollView.isHidden = indexPath == 1 ? false : true
        locationTermScrollView.isHidden = indexPath == 2 ? false : true

    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
