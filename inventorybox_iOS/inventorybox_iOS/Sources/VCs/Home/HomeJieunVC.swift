//
//  HomeJieunVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/09/10.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeJieunVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HomePageControlDelegate, UIViewControllerTransitioningDelegate {
    
    var whatPageIsIt: Int = 0
    
    @IBOutlet var homeLeftCV: UICollectionView!
    @IBOutlet var homeRightCV: UICollectionView!
    @IBOutlet var homePageControl: UIPageControl!
    private var checkOrderInfo : [HomeItem] = []
    private var leftCheckOrderInfo : [HomeItem] = []
    private var rightCheckOrderInfo : [HomeItem] = []
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var homeDetailBtn: UIButton!
    
    
    //test를 위한 더미 데이터 배열
    private var customData: [DataModel] = []
    private var customLeftData : [DataModel] = []
    private var customRightData : [DataModel] = []
    
    let transition = HomeSlideTransition()
    
    @IBOutlet var ingredientListView: UIView!
    @IBOutlet var bigCV: UICollectionView!
    var outerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
       // getDataFromServer()
        bigCV.delegate = self
        bigCV.dataSource = self
        homeDetailBtn.layer.cornerRadius = 15.0
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func hamburgerClickAction(_ sender: Any) {
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
        case .profile:
            guard let profileVC = self.storyboard?.instantiateViewController(identifier: "HomeSideProfileVC") as? HomeSideProfileVC else {return}

            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: true, completion: nil)

        case .myInfo:
            guard let myInfoVC = self.storyboard?.instantiateViewController(identifier: "HomeSideMyInfoVC") as? HomeSideMyInfoVC else {return}

            myInfoVC.modalPresentationStyle = .fullScreen
            self.present(myInfoVC, animated: true, completion: nil)

        case .post:
            print("")
        case .change:
            print("aa")
        case .setting:
            let settingStoryboard = UIStoryboard.init(name: "HomeSetting", bundle: nil)

            guard let settingVC = settingStoryboard.instantiateViewController(identifier: "HomeSettingNC") as? HomeNewNC else { return  }
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
           self.homePageControl.numberOfPages = ((self.customData.count/2)/7)+1
           self.outerCount = ((self.customData.count/2)/7)+1
           print(self.homePageControl.numberOfPages)
           DispatchQueue.main.async {
               self.bigCV.reloadData()
           }
      }

    
    func getDataFromServer(){
        
        HomeService.shared.getHome { networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    return }
                self.checkOrderInfo = dt.result
                
                for i in 0...self.checkOrderInfo.count - 1 {
                    if i % 2 == 0 {
                        //checkOrderInfo배열 중 인덱스가 짝수인 배열을 leftCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[0],checkOrderInfo[2],checkOrderInfo[4],checkOrderInfo[6] ... 번째 인덱스 즉 왼쪽 CV에 나타날 정보들
                        self.leftCheckOrderInfo.append(self.checkOrderInfo[i])
                    }
                    else {
                        //checkOrderInfo배열 중 인덱스가 홀수인 배열을 rightCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[1],checkOrderInfo[3],checkOrderInfo[5],checkOrderInfo[7] ... 번째 인덱스 즉 오른쪽 CV에 나타날 정보들
                        self.rightCheckOrderInfo.append(self.checkOrderInfo[i])
                    }
                }
                self.homePageControl.numberOfPages = ((self.checkOrderInfo.count/2)/7)+1
                self.outerCount = ((self.checkOrderInfo.count/2)/7)+1
                print(self.homePageControl.numberOfPages)
                DispatchQueue.main.async {
                    self.bigCV.reloadData()
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
    
    
    //MARK:- For Display the page number in page controll of collection view Cell
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let visibleRect = CGRect(origin: self.bigCV.contentOffset, size: self.bigCV.bounds.size)
           let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
           if let visibleIndexPath = self.bigCV.indexPathForItem(at: visiblePoint) {
               self.homePageControl.currentPage = visibleIndexPath.row
               whatPageIsIt = self.homePageControl.currentPage
            print(whatPageIsIt)
           }
       }
    
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let page = Int(targetContentOffset.pointee.x / bigCV.frame.width)
//        self.homePageControl.currentPage = page
//    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return outerCount
//    }
//    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
     return outerCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bigCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCVCell", for: indexPath) as! bigCVCell
        
        
        
        return bigCVCell
    }
    
    // 햄버거바 관련 controller
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

