//
//  TabBarVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        
        
    }
    
    func setTabBar() {
        
        self.tabBar.tintColor = UIColor.yellow
        
        // 1
        let Homes = UIStoryboard.init(name: "Homes", bundle: nil)
        guard let firstTab = Homes.instantiateViewController(identifier: "HomeVC")
            as? HomeVC  else {
                return
        }
        firstTab.tabBarItem.title = "홈"
        firstTab.tabBarItem.image = UIImage(named: "tabbarIcHomeUnselected")
        firstTab.tabBarItem.selectedImage = UIImage(named: "tabbarIcHomeSelected")
        
        // 2
        let IvReocrd = UIStoryboard.init(name: "IvRecord", bundle: nil)
        guard let secondTab = IvReocrd.instantiateViewController(identifier: "IvRecordVC")
            as? IvRecordVC  else {
                return
        }
        secondTab.tabBarItem.title = "재고 기록"
        secondTab.tabBarItem.image = UIImage(named: "tabbarIcRecordUnselected")
        secondTab.tabBarItem.selectedImage = UIImage(named: "tabbarIcRecordSelected")
        
        //3
        let IvGraph = UIStoryboard.init(name: "IvGraph", bundle: nil)
        guard let thirdTab = IvGraph.instantiateViewController(identifier: "IvGraphNC")
            as? IvGraphNC  else {
                return
        }
        thirdTab.tabBarItem.title = "재고량 추이"
        thirdTab.tabBarItem.image = UIImage(named: "tabbarIcStatusUnselected")
        thirdTab.tabBarItem.selectedImage = UIImage(named: "tabbarIcStatusSelected")
        
        // 4
//                let FourStoryboard = UIStoryboard.init(name: "Four", bundle: nil)
//                guard let fourthTab = FourStoryboard.instantiateViewController(identifier: "FourViewController")
//                    as? FourViewController  else {
//                    return
//                }
//                fourthTab.tabBarItem.title = "Chat"
//                fourthTab.tabBarItem.image = UIImage(named: "icTabChat")
//                fourthTab.tabBarItem.selectedImage = UIImage(named: "icSelectedChat")
//        
        //        // 5
        //        let MypageStoryboard = UIStoryboard.init(name: "Mypage", bundle: nil)
        //        guard let mypageTab = MypageStoryboard.instantiateViewController(identifier: "MypageViewController")
        //            as? MypageViewController  else {
        //            return
        //        }
        //        mypageTab.tabBarItem.title = "Mypage"
        //        mypageTab.tabBarItem.image = UIImage(named: "icTabMypage")
        //        mypageTab.tabBarItem.selectedImage = UIImage(named: "icSelectedMypage")
        
        let tabs =  [firstTab, secondTab, thirdTab]
        
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 3
        self.setViewControllers(tabs, animated: false)
    }
}



