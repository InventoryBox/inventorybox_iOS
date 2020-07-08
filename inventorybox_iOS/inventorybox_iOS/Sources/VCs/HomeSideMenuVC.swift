//
//  HomeSideMenuVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import SSCustomSideMenu

class HomeSideMenuVC: SSSideMenuContainerViewController {
    
    
    let menuTable = SSMenuTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSideMenu()
    }
    
    private func configureSideMenu() {
        
        self.menuTable.backgroundColor = .white
        menuTable.separatorStyle = .none
        menuTable.rowHeight = 60
        menuTable.showsHorizontalScrollIndicator = false
        menuTable.showsVerticalScrollIndicator = false
        
        let menuCellConfig = SSMenuCellConfig()
        
        menuCellConfig.cellStyle = .defaultStyle // .customStyle
        menuCellConfig.leftIconPadding = 20
        menuCellConfig.imageToTitlePadding = 10
        menuCellConfig.imageHeight = 24
        menuCellConfig.imageWidth = 24
        menuCellConfig.nonSelectedColor = .black
        
        menuCellConfig.images = [UIImage(named: "first"), UIImage(named: "second"), UIImage(named: "third"), UIImage(named: "logout")]
        menuCellConfig.titles = ["Home", "My Friends", "Settings", "Logout"]
        
        menuCellConfig.numberOfOptions = 4
        menuTable.config = menuCellConfig
        
        let sideMenuConfig = SSSideMenuConfig()
        sideMenuConfig.animationType = .slideIn // .slideIn, .compress(0.8, 20)
        sideMenuConfig.sideMenuPlacement = .right // .right
        sideMenuConfig.menuWidth = UIScreen.main.bounds.width * 0.5
        
        let firstViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC")
        
        sideMenuConfig.viewControllers = [firstViewController!]
        sideMenuConfig.menuTable = menuTable
        self.ssMenuConfig = sideMenuConfig
        
        self.sideMenuDelegate = self
    }
    
}

// MARK: - SSSideMenu Delegate

extension HomeSideMenuVC: SSSideMenuDelegate {
    
    func shouldOpenViewController(forMenuOption menuOption: Int) -> Bool {
        // Perform action for custom options (i.e logout)
        if menuOption == 3 {
            return false
        } else {
            return true
        }
    }
    
}
