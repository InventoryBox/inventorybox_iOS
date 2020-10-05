//
//  bigCVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/09/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class bigCVCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet var homeRightCV: UICollectionView!
    @IBOutlet var homeLeftCV: UICollectionView!
    private var checkOrderInfoInCell : [HomeItem] = []
    private var leftCheckOrderInfoInCell : [HomeItem] = []
    private var rightCheckOrderInfoInCell : [HomeItem] = []

    //test를 위한 더미 데이터 배열
    private var customData: [DataModel] = []
    private var customLeftData : [DataModel] = []
    private var customRightData : [DataModel] = []
    
    
    var whatPageIsIt : Int = 0
    
    override func awakeFromNib() {
        homeRightCV.dataSource = self
        homeRightCV.delegate = self
        homeLeftCV.dataSource = self
        homeLeftCV.delegate = self
       // getDataFromServer()
        setData()
    }
    
   
    
    func setData(){
        
        let cell1 = DataModel(salesName: "응")
        let cell2 = DataModel(salesName: "g")
        let cell3 = DataModel(salesName: "f")
        let cell4 = DataModel(salesName: "ff")
        let cell5 = DataModel(salesName: "ss")
        let cell6 = DataModel(salesName: "pp")
        let cell7 = DataModel(salesName: "l")
        let cell8 = DataModel(salesName: "oo")
        let cell9 = DataModel(salesName: "kk")
        let cell10 = DataModel(salesName: "ss")
        let cell11 = DataModel(salesName: "pp")
        let cell12 = DataModel(salesName: "l")
        let cell13 = DataModel(salesName: "oo")
        let cell14 = DataModel(salesName: "kk")
        let cell15 = DataModel(salesName: "ss")
        let cell16 = DataModel(salesName: "pp")
        let cell17 = DataModel(salesName: "l")
        let cell18 = DataModel(salesName: "oo")
        let cell19 = DataModel(salesName: "kk")
        
        customData = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10,cell11,cell12,cell13,cell14,cell15,cell16,cell17,cell18,cell19]
        
        
        
        
        for i in 0...self.customData.count - 1 {
            if i % 2 == 0 {
                //checkOrderInfo배열 중 인덱스가 짝수인 배열을 leftCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[0],checkOrderInfo[2],checkOrderInfo[4],checkOrderInfo[6] ... 번째 인덱스 즉 왼쪽 CV에 나타날 정보들
                self.customLeftData.append(self.customData[i])
            }
            else {
                //checkOrderInfo배열 중 인덱스가 홀수인 배열을 rightCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[1],checkOrderInfo[3],checkOrderInfo[5],checkOrderInfo[7] ... 번째 인덱스 즉 오른쪽 CV에 나타날 정보들
                self.customRightData.append(self.customData[i])
            }
        }
        DispatchQueue.main.async {
            self.homeLeftCV.reloadData()
            self.homeRightCV.reloadData()
        }
        print(customRightData.count)
        
   }
    
    func getDataFromServer(){
        
        HomeService.shared.getHome { networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    return }
                self.checkOrderInfoInCell = dt.result
                print(self.checkOrderInfoInCell)
                
                for i in 0...self.checkOrderInfoInCell.count - 1 {
                    if i % 2 == 0 {
                        //checkOrderInfo배열 중 인덱스가 짝수인 배열을 leftCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[0],checkOrderInfo[2],checkOrderInfo[4],checkOrderInfo[6] ... 번째 인덱스 즉 왼쪽 CV에 나타날 정보들
                        self.leftCheckOrderInfoInCell.append(self.checkOrderInfoInCell[i])
                    }
                    else {
                        //checkOrderInfo배열 중 인덱스가 홀수인 배열을 rightCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[1],checkOrderInfo[3],checkOrderInfo[5],checkOrderInfo[7] ... 번째 인덱스 즉 오른쪽 CV에 나타날 정보들
                        self.rightCheckOrderInfoInCell.append(self.checkOrderInfoInCell[i])
                    }
                }
                DispatchQueue.main.async {
                    self.homeLeftCV.reloadData()
                    self.homeRightCV.reloadData()
                }
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

//        if section < 4 {
//            return 7
//        }
//        else {
//            return leftCheckOrderInfoInCell.count % 7
//        }
//
//        if collectionView == homeLeftCV {
//            if leftCheckOrderInfoInCell.count < 7 {
//                print(leftCheckOrderInfoInCell.count)
//                return leftCheckOrderInfoInCell.count
//            }
//        }
//        else if collectionView == homeRightCV {
//            if rightCheckOrderInfoInCell.count < 7 {
//                print(rightCheckOrderInfoInCell.count)
//                return rightCheckOrderInfoInCell.count
//            }
//        }
//        
        if collectionView == homeLeftCV {
            if customLeftData.count < 7 {
                print(customLeftData.count)
                return customLeftData.count
            }
        }
        else if collectionView == homeRightCV {
            if customRightData.count < 7 {
                print(customRightData.count)
                return customRightData.count
            }
        }
        
        
        
        
        return customRightData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath)
        if indexPath.section == 0 {
          
            if collectionView == homeLeftCV {
                                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeMainLeftCVCell", for: indexPath) as! HomeMainLeftCVCell
                                

                cell.leftOrderIngredientLabel.text = customLeftData[indexPath.item].names
                print(indexPath.row)
                                
            //                      URL을 이미지로 변환 시키기
            //                    let url = URL(string: leftCheckOrderInfoInCell[indexPath.row].img)
            //                    let data = try? Data(contentsOf: url!)
            //                    cell.leftCheckImage.image = UIImage(data: data!)
            //
                                
                                return cell
                            }
                                
                            else if collectionView == homeRightCV {
                                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMainRigntCVCell", for: indexPath) as! HomeMainRigntCVCell
                    
                                cell2.rigntOrderIngredientLabel.text = customRightData[indexPath.item].names
                    
                                // URL을 이미지로 변환 시키기
            //                    let url = URL(string: rightCheckOrderInfoInCell[indexPath.row].img)
            //                    let data = try? Data(contentsOf: url!)
            //                    cell2.rightCheckImage.image = UIImage(data: data!)
            //
                                return cell2
                            }
        }
        
        else {
            if collectionView == homeLeftCV {
                                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeMainLeftCVCell", for: indexPath) as! HomeMainLeftCVCell
                                

                                cell.leftOrderIngredientLabel.text = customLeftData[indexPath.item].names
                print(indexPath.row)
                                
            //                      URL을 이미지로 변환 시키기
            //                    let url = URL(string: leftCheckOrderInfoInCell[indexPath.row].img)
            //                    let data = try? Data(contentsOf: url!)
            //                    cell.leftCheckImage.image = UIImage(data: data!)
            //
                                
                                return cell
                            }
                                
                            else if collectionView == homeRightCV {
                                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMainRigntCVCell", for: indexPath) as! HomeMainRigntCVCell
                    
                cell2.rigntOrderIngredientLabel.text = customRightData[indexPath.section].names
                    
                                // URL을 이미지로 변환 시키기
            //                    let url = URL(string: rightCheckOrderInfoInCell[indexPath.row].img)
            //                    let data = try? Data(contentsOf: url!)
            //                    cell2.rightCheckImage.image = UIImage(data: data!)
            //
                                return cell2
                            }
        }
             
            
        
        
               
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//       
//            return CGSize(width: 142, height: 18)
//        
//    }
    
}
