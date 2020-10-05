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
        let Homes = UIStoryboard.init(name: "IvHome", bundle: nil)
        guard let firstTab = Homes.instantiateViewController(identifier: "HomeNewNC")
            as? HomeNewNC  else {
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
        let IvGraph = UIStoryboard.init(name: "IvGraphNew", bundle: nil)
        guard let thirdTab = IvGraph.instantiateViewController(identifier: "IvGraphNC")
            as? IvGraphNC  else {
                return
        }
        thirdTab.tabBarItem.title = "재고량 추이"
        thirdTab.tabBarItem.image = UIImage(named: "tabbarIcStatusUnselected")
        thirdTab.tabBarItem.selectedImage = UIImage(named: "tabbarIcStatusSelected")
        
        // 4
        let IvExchange = UIStoryboard.init(name: "IvExchange", bundle: nil)
        guard let fourthTab = IvExchange.instantiateViewController(identifier: "IvExchangeNaviVC")
            as? IvExchangeNaviVC  else {
                return
        }
        fourthTab.tabBarItem.title = "재고 교환"
        fourthTab.tabBarItem.image = UIImage(named: "tabbarIcExchangeUnselected")
        fourthTab.tabBarItem.selectedImage = UIImage(named: "tabbarIcExchangeSelected")
        
        
        let tabs =  [firstTab, secondTab, thirdTab, fourthTab]
        
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 3
        self.setViewControllers(tabs, animated: false)
    }
}



