//
//  HomeVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var collectionview: UICollectionView!   // collectionview Olet정의
    
    // 연습
    var titleList = ["우유", "녹차파우더", "딸기", "헤이즐넛시럽", "모카파우더"]
    var checkList = [true, false, true, true, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()     // setCollectionView 실행
    
    }
    
    
    // MARK: CollectionView에 Cell을 넣기 위한 setting
    func setCollectionView(){
        
        collectionview.delegate = self
        collectionview.dataSource = self
        
        // MARK: Xib를 cell로 가져오는 방법
        collectionview.register(UINib(nibName: "Home1CVCell", bundle: nil), forCellWithReuseIdentifier: "Home1CVCell")
        
        collectionview.register(UINib(nibName: "Home2CVCell", bundle: nil), forCellWithReuseIdentifier: "Home2CVCell")
        
        collectionview.register(UINib(nibName: "Home3CVCell", bundle: nil), forCellWithReuseIdentifier: "Home3CVCell")
        
        collectionview.register(UINib(nibName: "Home4CVCell", bundle: nil), forCellWithReuseIdentifier: "Home4CVCell")
        
        
        // MARK: Xib를 header로 가져오는 방법
        //        self.collectionview.register(UINib(nibName: "Home1VCCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Home1VCCell")
        //
        //        // Home2VCCell 가져오기
        //        self.collectionview.register(UINib(nibName: "Home2VCCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Home2VCCell")
        //
        //        // Home3VCCell 가져오기
        //        self.collectionview.register(UINib(nibName: "Home3VCCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Home3VCCell")
        //
    }
    
}

// MARK: UICollectionViewDelegate 정의
extension HomeVC: UICollectionViewDelegate{
}

// MARK: UICollectionViewDataSource 정의
extension HomeVC: UICollectionViewDataSource{
    
    // CollectionView의 Section의 개수를 묻는 메서드, 이 메서드를 구현하지 않으면 섹션 개수 기본 값은 1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    // 지정된 Section에 표시할 항목의 개수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (section==0) {
            return 1
        }
        return titleList.count
    }
    
    // CollectionView 지정된 위치에 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {         // CollectionView 일 때
        case self.collectionview:       // 화면에 띄워진
            switch indexPath.section {
            case 0:
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Home1CVCell", for: indexPath) as! Home1CVCell
                return cell1
                
                // 왼쪽 오른쪽 나오는 알고리즘
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            case 1:
                // 왼쪽 리스트
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "Home2CVCell", for: indexPath) as! Home2CVCell
                
                let check = checkList[indexPath.row/2]
                if check == true {
                    cell2.productImg.image = UIImage(named: "homeIcAble.png")
                }
                else {
                    cell2.productImg.image = UIImage(named: "homeIcUnable.png")
                }
                cell2.titleLabel.text = titleList[indexPath.row/2]
                return cell2
                
            case 2:
                // 오른쪽 리스트
                let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "Home3CVCell", for: indexPath) as! Home3CVCell
                
                // Mission: list의 짝수 부분만 return 하기
                let check = checkList[indexPath.row/2+1]
                if check == true {
                    cell3.productImg.image = UIImage(named: "homeMemoShape.png")
                }
                else {
                    cell3.productImg.image = UIImage(named: "homeImgProfile.png")
                }
                cell3.titleLabel?.text = titleList[indexPath.row/2+1]
                return cell3
                
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                
            case 3:
                let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "Home4CVCell", for: indexPath) as! Home4CVCell
                return cell4
                
            default:
                return UICollectionViewCell()
            }
            
        default:
            return UICollectionViewCell()
        }
        
    }
}


// MARK: UICollectionViewDelegateFlowLayout 정의
extension HomeVC: UICollectionViewDelegateFlowLayout{
    
    // cell의 갯수를 정하고 CollectionView를 리로드해 줌
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        if (kind ==  UICollectionView.elementKindSectionHeader) {
            let section = indexPath.section
            switch (section) {
            case 0:
                let  firstheader: Home1CVCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Home1CVCell", for: indexPath) as! Home1CVCell
                reusableview = firstheader
            case 1:
                let  secondHeader: Home2CVCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Home2CVCell", for: indexPath) as! Home2CVCell
                reusableview = secondHeader
            case 2:
                let  thirdHeader: Home3CVCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Home3CVCell", for: indexPath) as! Home3CVCell
                reusableview = thirdHeader
            case 3:
                let  fourthHeader: Home4CVCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Home4CVCell", for: indexPath) as! Home4CVCell
                reusableview = fourthHeader
            default:
                return reusableview
            }
        }
        return reusableview
    }
    
    // MARK: section별 cell의 사이즈 변화
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {  // 값을 넣지 말고 변형될 수 있도록 계산해야 됨!
        case 0:
            return CGSize(width: self.view.frame.width, height: 450)
        case 1:
            return CGSize(width: self.view.frame.width, height: 25)
        case 2:
            return CGSize(width: self.view.frame.width, height: 25)
        case 3:
            return CGSize(width: 343, height: 94)
        default:
            return CGSize(width: self.view.frame.width, height: 450)
        }
        
    }
    
    // 지정된 Section의 HeaderView의 크기를 반환하는 메서드, 지정하지 않으면 화면에 보이지 않는다
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //
    //        if(section==0) {    // 첫번째 Home1에 대한 Cell의 높이
    //            return CGSize(width:collectionView.frame.size.width, height:450)
    //        } else if (section==1) {    // 첫번째 Home2에 대한 Cell의 높이
    //            return CGSize(width:collectionView.frame.size.width, height:133)
    //        } else if (section==2) {    // 첫번째 Home3에 대한 Cell의 높이
    //            return CGSize(width:collectionView.frame.size.width, height:133)
    //        } else {    // 첫번째 Home3에 대한 Cell의 높이
    //            return CGSize(width:collectionView.frame.size.width, height:100)
    //        }
    //
    //    }
    
}
