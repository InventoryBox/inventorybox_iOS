//
//  HomeVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var leftcollectionview: UICollectionView!    // 왼쪽 coolection
    @IBOutlet weak var rightcollectionview: UICollectionView!   // 오른쪽 collection
    @IBOutlet weak var tableview: UITableView!  // table
    
    
    // collection에 연결할 더미 데이터
    private var checklistInformations : [orderCheckCVCInfo] = [ ]
    
    // table에 연결할 더미 데이터
    private var orderCheckInformations : [orderCheckTVCInfo] = [ ]

    // override
    override func viewDidLoad() {
        super.viewDidLoad()
              
        // collection관련 데이터
        setchecklistInformations()
        
        // table관련 데이터
        setorderCheckInformations()
        
        // table
        tableview.dataSource = self
        tableview.delegate = self
        // collection
        leftcollectionview.dataSource = self
        rightcollectionview.dataSource = self
        leftcollectionview.delegate = self
        rightcollectionview.delegate = self
    }
    
    
    
    // MARK: CollectionView 관련 더미데이터
    private func setchecklistInformations() {
        
        let data1 = orderCheckCVCInfo(productimage: "homeIcAble.png", productname: "우유")
        let data2 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "녹차 파우더")
        let data3 = orderCheckCVCInfo(productimage: "homeIcAble.png", productname: "딸기")
        let data4 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "원두")
        let data5 = orderCheckCVCInfo(productimage: "homeIcAble.png", productname: "허니 시럽")
        let data6 = orderCheckCVCInfo(productimage: "homeIcAble.png", productname: "모카 파우더")
        // FriendsInformation = FriendsInformation
        
        checklistInformations = [data1, data2, data3, data4, data5, data6]
    }
      
    
    
    // MARK: TableView 관련 더미데이터
    private func setorderCheckInformations() {

        let data1 = orderCheckTVCInfo(productimage: "homeIcMilk.png", productname: "우유", productcount: "9999", productset: "덩어리")
        let data2 = orderCheckTVCInfo(productimage: "homeIcGreenpowder.png", productname: "녹차 파우더", productcount: "1", productset: "팩")
        let data3 = orderCheckTVCInfo(productimage: "homeIcStrawberry.png", productname: "딸기", productcount: "555", productset: "개")
        let data4 = orderCheckTVCInfo(productimage: "homeIcCoffee.png", productname: "원두", productcount: "42", productset: "팩")
        let data5 = orderCheckTVCInfo(productimage: "homeIcHssyrup.png", productname: "허니 시럽", productcount: "5", productset: "병")
        let data6 = orderCheckTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: "12", productset: "팩")
        // FriendsInformation = FriendsInformation

            orderCheckInformations = [data1, data2, data3, data4, data5, data6]
    }
    
}

// MARK: LeftCollectionView DataSource 관련 코드
extension HomeVC: UICollectionViewDataSource{
    // section 뱔 row의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checklistInformations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
// 여기서 if문을 돌려 왼쪽일 때
        if collectionView == self.leftcollectionview{
        guard let LeftCells = collectionView.dequeueReusableCell(withReuseIdentifier: LeftCVCell.identifier, for: indexPath) as? LeftCVCell else { return UICollectionViewCell()}
        
        LeftCells.set(checkimg: checklistInformations[indexPath.row].checkImage, productlist: checklistInformations[indexPath.row].productName)
            
            return LeftCells
        }else{
            guard let RightCells = collectionView.dequeueReusableCell(withReuseIdentifier: RightCVCell.identifier, for: indexPath) as? RightCVCell else { return UICollectionViewCell()}
        
        RightCells.set(checkimg: checklistInformations[indexPath.row].checkImage, productlist: checklistInformations[indexPath.row].productName)
        
        return RightCells
        }
        
        
// @@@@@@@@@@@@@@@@@@@@@@@@
    }
}
// MARK: LeftCollectionView Delegate 관련 코드
extension HomeVC: UICollectionViewDelegate{
    
}






// MARK: UITableViewDataSource 관련 코드
extension HomeVC: UITableViewDataSource{
    // 테이블에 표시할 데이터 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderCheckInformations.count
    }
    
    // cell 에 값 넣기!!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Cells = tableView.dequeueReusableCell(withIdentifier: HomeTVCell.identifier, for:
        indexPath) as? HomeTVCell else { return UITableViewCell()}
        
        Cells.SetProductImformation(productImage: orderCheckInformations[indexPath.row].productImage, productNameTx: orderCheckInformations[indexPath.row].productName, productCountTx: orderCheckInformations[indexPath.row].productCount, productSetTx: orderCheckInformations[indexPath.row].productSet)

        
        return Cells
    }
    
}
// MARK: UITableViewDelegate 관련 코드
extension HomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    // tableView 선택 안되게 하기!
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//
    
}
