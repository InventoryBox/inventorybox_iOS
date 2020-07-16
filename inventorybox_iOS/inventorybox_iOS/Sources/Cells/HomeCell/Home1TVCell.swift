//
//  Home1TVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

//extension NSNotification.Name {
//
//    static let notifyHeight = NSNotification.Name(rawValue: "notifyHeight")
//}


class Home1TVCell: UITableViewCell {
    
    let identifier : String = "Home1TVCell"
    
    // 더미데이터
    private var checklistInformations : [orderCheckCVCInfo] = [ ]
    
    // shadow 넣기 위한 view
    //    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Home CollectionView 관련 data
        setchecklistInformations()
        // 그림자 넣기
        makeShadowUnderView()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        
//        print(collectionview.frame.height)
        
        NotificationCenter.default.post(name: .init("notifyHeight"), object: nil, userInfo: ["cvheight": collectionview.frame.height])
        
        NotificationCenter.default.addObserver(self, selector: #selector(getChekcList), name: .init("checklist"), object: nil)
        
    }
    @objc private func getChekcList(_ notification: Notification) {
        //        print("second return")
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let checkvalue = userInfo["bool"] as? Bool else { return }
        guard let ivName = userInfo["name"] as? String else { return }

        
//        print(checkvalue)
//        print(ivName)
        for i in 0..<checklistInformations.count{
            if checklistInformations[i].productName == ivName{
                if checkvalue == true{
                    checklistInformations[i].checkImage =  "homeIcAble.png"
                }else{
                    checklistInformations[i].checkImage = "homeIcUnable.png"
                }
            }
            collectionview.reloadData()
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func makeShadowUnderView() {
        // 그림자주는 코드
        //         roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //         roundView.layer.shadowOpacity = 0.1
        //         roundView.layer.shadowRadius = 8// 퍼지는 정도
        //         roundView.layer.cornerRadius = 10
    }
    
    // 이거는 collection view에 사용할 자료
    private func setchecklistInformations() {
        
        let data1 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "우유")
        let data2 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "녹차 파우더")
        let data3 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "딸기")
        let data4 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "원두")
        let data5 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "허니 시럽")
        let data6 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "모카 파우더")
        let data7 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "모카 파우더")
        let data8 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "모카 파우더")
        let data9 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "모카 파우더")
        let data10 = orderCheckCVCInfo(productimage: "homeIcUnable.png", productname: "모카 파우더")
        
        // FriendsInformation = FriendsInformation
        
        checklistInformations = [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10]
        //        checklistInformations = [data1]
    }
    
}

// MARK: DdataSource 관련 extention
extension Home1TVCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return checklistInformations.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let collectionCells = collectionView.dequeueReusableCell(withReuseIdentifier: "Home1CVCell", for: indexPath) as? Home1CVCell else { return UICollectionViewCell()}
        
        collectionCells.set(checkimg: checklistInformations[indexPath.row].checkImage, productlist: checklistInformations[indexPath.row].productName)
        
        return collectionCells
    }
    
    
}

// MARK: DelegateFlowLayout 관련 extention
extension Home1TVCell: UICollectionViewDelegateFlowLayout {
    
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
    //    indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: (collectionView.frame.width-40) / 2, height: collectionView.frame.height / 4)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //    return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //    return 20
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //    return 26
    //    }
    
}

// MARK: DdataSource 관련 extention
extension Home1TVCell : UICollectionViewDelegate{
    
}
