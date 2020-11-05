//
//  HomeNewVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/08/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeNewVC: UIViewController {

    @IBOutlet weak var homeListCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var detailButton: UIView!
 
    var page : Int = 0      // page 개수 관련 변수
    var curentpage : Int = 0
    
    var leftValue : Int?        // 몫 값
    var leftRemainder : Int?    // 나머지 값
    var rigntValue : Int?        // 몫 값
    var rigntRemainder : Int?    // 나머지 값
    
    // 사이드바 만든거 사용하기 위해
    let transition = HomeSlideTransition()

    //test를 위한 더미 데이터 배열
    private var customData: [DataModel] = []
    private var customLeftData : [DataModel] = []
    private var customRightData : [DataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        homeListCollectionView.dataSource = self
        homeListCollectionView.delegate = self
        
        
        pages()
//        configureScrollView()   //
        makeShadowUnderView()   // 그림자 & Radious
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: sideMenuBar 눌렀을 떄 행동
    @IBAction func sideMenuBarAction(_ sender: Any) {
        guard let sideMenuBarVC = storyboard?.instantiateViewController(withIdentifier: "HomeNewSideMenuVC") as? HomeNewSideMenuVC else {return }
        
        sideMenuBarVC.didTapMenuType = {menuType in
            self.transtionToNew(menuType)
            // print(menuType)
        }
        sideMenuBarVC.modalPresentationStyle = .overCurrentContext
        sideMenuBarVC.transitioningDelegate = self
        
        present(sideMenuBarVC, animated: true)
        
        // MARK: 회색 처리된 배경 누르면 dismiss 되게 만들기
        let tap = UITapGestureRecognizer(target: self, action:    #selector(self.handleTap(_:)))
        // dimingView(gray 배경)에 (tap)제스쳐를 입히겠다
        transition.dimingView.addGestureRecognizer(tap)
    }
    
    func transtionToNew(_ menuType : MenuType){

        switch menuType{
        
        // 프로필 변경
        case .profile:
            guard let profileVC = self.storyboard?.instantiateViewController(identifier: "HomeSideProfileVC") as? HomeSideProfileVC else {return}

            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: true, completion: nil)

        // 개인 정보 변경
        case .myInfo:
            guard let myInfoVC = self.storyboard?.instantiateViewController(identifier: "MyInfoNC") as? MyInfoNC else {return}

            myInfoVC.modalPresentationStyle = .fullScreen
            self.present(myInfoVC, animated: true, completion: nil)
          
        // 내가 쓴 게시글
        case .post:
            guard let userPostVC = self.storyboard?.instantiateViewController(identifier: "IvHomeSideUserPostVC") as? IvHomeSideUserPostVC else { return }
            
            userPostVC.modalPresentationStyle = .fullScreen
            self.present(userPostVC, animated: true, completion: nil)
            
        // 비밀번호 변경
        case .change:
            guard let passwordChangeVC = self.storyboard?.instantiateViewController(identifier: "HomeSidePasswordChangeVC") as? HomeSidePasswordChangeVC else { return }
            
            passwordChangeVC.modalPresentationStyle = .fullScreen
            self.present(passwordChangeVC, animated: true, completion: nil)
        
        // 설정
        case .setting:
            let settingStoryboard = UIStoryboard.init(name: "HomeSetting", bundle: nil)

            guard let settingVC = settingStoryboard.instantiateViewController(identifier: "HomeSettingNC") as? HomeSettingNC else { return  }
            settingVC.modalPresentationStyle = .fullScreen

            self.present(settingVC, animated: true, completion: nil)
        }

    }
    
    // objc 함수를 통해 행동을 정의
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func setData(){
        
        let cell1 = DataModel(salesName: "응")
        let cell2 = DataModel(salesName: "g")
        let cell3 = DataModel(salesName: "f")
        let cell4 = DataModel(salesName: "ff")
        let cell5 = DataModel(salesName: "ss")
        let cell6 = DataModel(salesName: "고기")
        let cell7 = DataModel(salesName: "고기")
        let cell8 = DataModel(salesName: "우유")
        let cell9 = DataModel(salesName: "빵")
        let cell10 = DataModel(salesName: "맘마")
        let cell11 = DataModel(salesName: "녹차")
        let cell12 = DataModel(salesName: "크림")
        let cell13 = DataModel(salesName: "파스타")
        let cell14 = DataModel(salesName: "kk")
        let cell15 = DataModel(salesName: "멍멍이")
        let cell16 = DataModel(salesName: "pp")
        let cell17 = DataModel(salesName: "바보")
        let cell18 = DataModel(salesName: "oo")
        let cell19 = DataModel(salesName: "강아지")
        let cell20 = DataModel(salesName: "kk")
        let cell21 = DataModel(salesName: "헤헤")
        let cell22 = DataModel(salesName: "kk")
        let cell23 = DataModel(salesName: "호호")
        let cell24 = DataModel(salesName: "kk")
        let cell25 = DataModel(salesName: "히히")
        let cell26 = DataModel(salesName: "kk")
        let cell27 = DataModel(salesName: "kk")
        let cell28 = DataModel(salesName: "kk")
        let cell29 = DataModel(salesName: "kk")
        let cell30 = DataModel(salesName: "kk")
   
        
        customData = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10,cell11,cell12,cell13,cell14,cell15,cell16,cell17,cell18,cell19,cell20,cell21,cell22,cell23,cell24,cell25,cell26,cell27,cell28,cell29,cell30]
        
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
        
        leftValue = customLeftData.count/7      // 7로 나눴을때 몫
        leftRemainder = customLeftData.count%7  // 7로 나눴을때 나머지
        rigntValue = customRightData.count/7    //
        rigntRemainder = customRightData.count%7    //
        
   }
    
    // page controller 개수
    func pages() {
        homeListCollectionView?.isPagingEnabled = true
        
        page = 1 + customData.count / 14         // 14로 나눴을 때
        pageControl.numberOfPages = page    // pagecontrol의 점 개수
    }
    
    

    
    
    // 그림자주는 코드
     private func makeShadowUnderView() {
         
                  detailButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                  detailButton.layer.shadowOpacity = 0.1
                  detailButton.layer.shadowRadius = 8// 퍼지는 정도
                  detailButton.layer.cornerRadius = 14
     }
}


// MARK: UICollectionView DataSource
extension HomeNewVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return page
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeNewCVCell", for: indexPath) as? HomeNewCVCell else {return UICollectionViewCell() }
        
        // 왼쪽 페이지 수 맞춰서 값을 넣음
        for i in 0..<leftValue!{
            if indexPath.item == i{
                switch i{
                case 0:
                    for j in 0..<7{
                        if listCell.leftStackview[j].tag == j+1{
                            listCell.leftStackview[j].text = "\(String(describing: self.customLeftData[j].names!))"
                        }
                    }
                case 1:
                    for j in 0..<7{
                        if listCell.leftStackview[j].tag == j+1{
                            listCell.leftStackview[j].text = "\(String(describing: self.customLeftData[j+7].names!))"
                        }
                    }
                case 2:
                    for j in 0..<7{
                        if listCell.leftStackview[j].tag == j+1{
                            listCell.leftStackview[j].text = "\(String(describing: self.customLeftData[j+14].names!))"
                        }
                    }
                case 3:
                    for j in 0..<7{
                        if listCell.leftStackview[j].tag == j+1{
                            listCell.leftStackview[j].text = "\(String(describing: self.customLeftData[j+21].names!))"
                        }
                    }
                case 4:
                    for j in 0..<7{
                        if listCell.leftStackview[j].tag == j+1{
                            listCell.leftStackview[j].text = "\(String(describing: self.customLeftData[j+28].names!))"
                        }
                    }
                default: break
                }
            }
        }
        
        // 오른쪽 Stack관련
        for i in 0..<rigntValue!{
            if indexPath.item == i{
                switch i{
                case 0:
                    for j in 0..<7{
                        if listCell.rigntStackView[j].tag == j+1{
                            listCell.rigntStackView[j].text = "\(self.customRightData[j].names!)"
                        }
                    }
                case 1:
                    for j in 0..<7{
                        if listCell.rigntStackView[j].tag == j+1{
                            listCell.rigntStackView[j].text = "\(self.customRightData[j+7].names!)"
                        }
                    }
                case 2:
                    for j in 0..<7{
                        if listCell.rigntStackView[j].tag == j+1{
                            listCell.rigntStackView[j].text = "\(self.customRightData[j+14].names!)"
                        }
                    }
                case 3:
                    for j in 0..<7{
                        if listCell.rigntStackView[j].tag == j+1{
                            listCell.rigntStackView[j].text = "\(self.customRightData[j+21].names!)"
                        }
                    }
                case 4:
                    for j in 0..<7{
                        if listCell.rigntStackView[j].tag == j+1{
                            listCell.rigntStackView[j].text = "\(self.customRightData[j+28].names!)"
                        }
                    }
    
                default: break
                }
            }
        }
        
        // 나머지에 관하여 왼쪽 값
        if indexPath.item == leftValue!{
            // 나머지 값에 관해서
            for i in 0..<leftRemainder!{
                if listCell.leftStackview[i].tag == i+1 {
                    listCell.leftStackview[i].text = "\(String(describing: self.customLeftData[i+(leftValue!*7)].names!))"
                    
                }
            }
            // 그 이후 나오지 말아야 하는 값들
            for i in leftRemainder!..<7 {
                if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                    listCell.leftStackview[i].text = " "
                    listCell.leftStackImage[i].image = UIImage(named: "homeIcUnable")
                }
            }
        }
        
        // 나머지에 관하여 오른쪽 값
        if indexPath.item == rigntValue!{
            // 나머지 값에 관해서
            for i in 0..<rigntRemainder!{
                if listCell.rigntStackView[i].tag == i+1 {
                    listCell.rigntStackView[i].text = "\(String(describing: self.customRightData[i+(rigntValue!*7)].names!))"
                    
                }
            }
            
            for i in rigntRemainder!..<7 {
                if listCell.rigntStackView[i].tag == i+1 && listCell.rigntStackImage[i].tag == i+1 {
                    listCell.rigntStackView[i].text = " "
                    listCell.rigntStackImage[i].image = UIImage(named: "homeIcUnable")
                }
            }
        }

        return listCell
        
    }
}
    
    
    // MARK: UICollectionView Delegate
extension HomeNewVC: UICollectionViewDelegate{
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        curentpage = Int(targetContentOffset.pointee.x / homeListCollectionView.frame.size.width)
//      self.pageControl.currentPage = curentpage
//
//        print("\(curentpage)")
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        curentpage =  Int(floorf(Float(homeListCollectionView.contentOffset.x)/Float(homeListCollectionView.frame.size.width)))

        pageControl.currentPage = curentpage

    }
    
}

//  MARK: sideMenu 만든 Delegate
extension HomeNewVC : UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}


