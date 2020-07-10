//
//  HomeVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox
import SideMenu

class HomeVC: UIViewController {
  
    // table에 연결할 더미 데이터
    private var orderCheckInformations : [orderCheckTVCInfo] = [ ]
    private var height: CGFloat?
    
    @IBOutlet weak var tableview: UITableView! // 전체 TableView
  
    // MARK: override 부분
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setStockHeight), name: .init("notifyHeight"), object: nil)

        // table관련 데이터
        setorderCheckInformations()
        
        // table
        tableview.dataSource = self
        tableview.delegate = self
        
        // tableView 안눌리게
        tableview.allowsSelection = false
        tableview.separatorStyle = .none
        tableview.contentInsetAdjustmentBehavior = .never
        setUpSlideMenu()
    }
    
    @objc func setStockHeight(_ notification: NSNotification) {
        
        guard let height = notification.userInfo?["cvheight"] as? CGFloat else { return }
        
        self.height = height
        
        print(height)
        
        tableview.reloadData()
    }
    
    // @@@@@@@@@@@
    func setUpSlideMenu() {
        // 1. Side Menu ViewController 만들기
        
        let sideMenu = HamburgerBarVC(nibName: "HamburgerBarVC", bundle: nil)
        
        // 2. UISideMenuNavigationController 생성시키기.
        let sideNavigation = SideMenuNavigationController(rootViewController: sideMenu)
        // 3. 셋팅하기.
        SideMenuManager.default.rightMenuNavigationController = sideNavigation
        
        // 3-1. 열리는 방식 셋팅 (내가 필요한 순서)
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        
        SideMenuManager.default.menuFadeStatusBar = false
        
        SideMenuManager.default.menuAnimationFadeStrength = 0.3 // (뒤에 보이는 정도 흐르기)
        
        // 4. 스와이프 열고 닫기 켜기
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
    }
    
    
    @IBAction func hamburgerbarpress(_ sender: Any) {
        
        present(SideMenuManager.default.rightMenuNavigationController!, animated: true , completion:  nil)
        
    }
// @@@@@@@@@@@
    
    // MARK: TableView 관련 더미데이터
    private func setorderCheckInformations() {
        
        let data1 = orderCheckTVCInfo(productimage: "homeIcMilk.png", productname: "우유", productcount: "9999", productset: "덩어리")
        let data2 = orderCheckTVCInfo(productimage: "homeIcGreenpowder.png", productname: "녹차 파우더", productcount: "1", productset: "팩")
        let data3 = orderCheckTVCInfo(productimage: "homeIcStrawberry.png", productname: "딸기", productcount: "555", productset: "개")
        let data4 = orderCheckTVCInfo(productimage: "homeIcCoffee.png", productname: "원두", productcount: "42", productset: "팩")
        let data5 = orderCheckTVCInfo(productimage: "homeIcHssyrup.png", productname: "허니 시럽", productcount: "5", productset: "병")
        let data6 = orderCheckTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: "12", productset: "팩")
        let data7 = orderCheckTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: "12", productset: "팩")
        
        orderCheckInformations = [data1, data2, data3, data4,data5,data6,data7]
    }
}


// MARK: UITableViewDataSource 관련 코드
extension HomeVC: UITableViewDataSource{
    
    // section 개수를 정의해주는 함수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         각 section에 맞게
        if section == 0{
            return 2
        }else{
            print(orderCheckInformations)
            return orderCheckInformations.count
        }
    }
    
    
// MARK: UITableViewDelegate 관련 코드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // section == 0 위에꺼
        if indexPath.section == 0{

            if indexPath.row == 0{
                 // header1
                guard let headerCell1 = tableView.dequeueReusableCell(withIdentifier: "HomeHeader1TVCell", for: indexPath) as? HomeHeader1TVCell else { return UITableViewCell() }

                return headerCell1

            }else{
                // tableviewcell2 -> collectionviewcell
                guard let Cell1s = tableView.dequeueReusableCell(withIdentifier: "Home1TVCell", for: indexPath) as? Home1TVCell else { return UITableViewCell() }
                
                return Cell1s
            }
            
        }else{
            //             section == 1 밑에꺼
            guard let Cell2s = tableView.dequeueReusableCell(withIdentifier: "Home2TVCell", for: indexPath) as? Home2TVCell else { return UITableViewCell() }
            Cell2s.SetProductImformation(productImage: orderCheckInformations[indexPath.row].productImage, productNameTx: orderCheckInformations[indexPath.row].productName, productCountTx: orderCheckInformations[indexPath.row].productCount, productSetTx: orderCheckInformations[indexPath.row].productSet)
            
            return Cell2s
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            if section == 1 {
                guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHeader2TVCell") as? HomeHeader2TVCell else { return UICollectionViewCell() }
                return headerCell
            } else { return nil }
    }
}


extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                return 44
            }
            else {
                // collection view height에 맞게 변화
                guard let height = self.height else { return 0 }
                print("ㄴㄴㄴ\(height)")
                
                return UITableView.automaticDimension
            }
            
        }else{
            // tableview 높이
                return 94
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 { return 44 }
        else { return 0 }
    }
}



