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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    
    var didTapMenuType : ((MenuType) -> Void)?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        
        
        IvHomeHamburgerProfileService.shared.getProfile { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? ProfileData else { return }
                self.nameLabel.text = dt.nickname
                self.storeNameLabel.text = dt.coName
                let url = URL(string: dt.img)
                self.profileImageView.kf.setImage(with: url)

            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
           guard let menuType = MenuType(rawValue: indexPath.row) else {return }
        
        dismiss(animated: true){ [weak self] in
            print("dismissing \(menuType)")
            self?.didTapMenuType?(menuType)
        }
        
    }
    
}

