//
//  HomeNewSideMenuVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/03.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Kingfisher

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
   
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getDataFromServer()
       
    }
    
    
    
    
    //MARK: Home 데이터 받아오기
      func getDataFromServer(){
          
        HomeHamburgerBarUserProfileService.shared.getHomeHamburgerBarUserProfile { networkResult in
              switch networkResult{
              case .success(let data):
                  guard let dt = data as? profile else {
                      
                      return }
                  
                  // kingfisher
                  let url = URL(string: dt.img)
                  self.profileImage.kf.setImage(with: url)
                  
                  self.profileName.text = dt.nickname
                  self.storeName.text = dt.coName
                
//                  Di
//                  spatchQueue.main.async {
//                      self.tableview.reloadData()
//                  }
                
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
    

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           guard let menuType = MenuType(rawValue: indexPath.row) else {return }
        
        dismiss(animated: true){ [weak self] in
            print("dismissing \(menuType)")
            self?.didTapMenuType?(menuType)
        }
        
    }
    
}


//// MARK: - profile
//struct profile: Codable {
//    let nickname: String
//    let img: String
//    let coName: String
//}
//
