//
//  HomeNewSideMenuVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/03.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit


enum MenuType: Int{
    case profile
    case myInfo
    case post
    case change
    case setting
}
    
// 애초에 tableview로 만들기
class HomeNewSideMenuVC: UITableViewController {

    var didTapMenuType : ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
           guard let menuType = MenuType(rawValue: indexPath.row) else {return }
        
        dismiss(animated: true){ [weak self] in
            print("dismissing \(menuType)")
            self?.didTapMenuType?(menuType)
        }
        
    }
    
}

