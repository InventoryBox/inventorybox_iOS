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
 
    var page : Int = 2      // page 개수 관련 변수
    var curentpage : Int = 0
       
    let setInformations : [Int] = [1,2,3,4,5,6,7,2,13,5,2,1,2,3,15,2,23,1,2,2,3,1,2,5,2,1,2,3,51,2,5,2,1,5,2,1,2,3,4,1,25,2]
    
    // Side Bar Menu 만든거 사용
//    let transition = HomeSlideTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        homeListCollectionView.dataSource = self
        homeListCollectionView.delegate = self
        
        pages()
        configureScrollView()   //
        makeShadowUnderView()   // 그림자 & Radious
       
    }

    // MARK: sideMenuBar 눌렀을 떄 행동
    @IBAction func sideMenuBarAction(_ sender: Any) {
//        guard let sideMenuBarVC = storyboard?.instantiateViewController(withIdentifier: "HomeNewSideMenuVC") as? HomeNewSideMenuVC else {return }
//
//        sideMenuBarVC.didTapMenuType = {menuType in
//            self.transtionToNew(menuType)
//            // print(menuType)
//        }
//        sideMenuBarVC.modalPresentationStyle = .overCurrentContext
//        sideMenuBarVC.transitioningDelegate = self
//
//        present(sideMenuBarVC, animated: true)
//
//        // MARK: 회색 처리된 배경 누르면 dismiss 되게 만들기
//        let tap = UITapGestureRecognizer(target: self, action:    #selector(self.handleTap(_:)))
//        // dimingView(gray 배경)에 (tap)제스쳐를 입히겠다
//        transition.dimingView.addGestureRecognizer(tap)
    }
    
//    func transtionToNew(_ menuType : MenuType){
//
//        switch menuType{
//        case .profile:
//            guard let profileVC = self.storyboard?.instantiateViewController(identifier: "HomeSideProfileVC") as? HomeSideProfileVC else {return}
//
//            profileVC.modalPresentationStyle = .fullScreen
//            self.present(profileVC, animated: true, completion: nil)
//
//        case .myInfo:
//            guard let myInfoVC = self.storyboard?.instantiateViewController(identifier: "HomeSideMyInfoVC") as? HomeSideMyInfoVC else {return}
//
//            myInfoVC.modalPresentationStyle = .fullScreen
//            self.present(myInfoVC, animated: true, completion: nil)
//
//        case .post:
//            print("")
//        case .change:
//            print("aa")
//        case .setting:
//            let settingStoryboard = UIStoryboard.init(name: "HomeSetting", bundle: nil)
//
//            guard let settingVC = settingStoryboard.instantiateViewController(identifier: "HomeSettingNC") as? HomeNewNC else { return  }
//            settingVC.modalPresentationStyle = .fullScreen
//
//            self.present(settingVC, animated: true, completion: nil)
//        }
//
//    }
//    
//    // objc 함수를 통해 행동을 정의
//    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        dismiss(animated: true, completion: nil)
//    }
    
    
    // page controller 개수
    func pages() {
        page = 1 + setInformations.count / 15         // 15로 나눴을 때
        print("현제 페이지의 개수는 --> \(page)")
        pageControl.numberOfPages = page    // pagecontrol의 점 개수
    }
    
    

    
    
    // 그림자주는 코드
     private func makeShadowUnderView() {
         
                  detailButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                  detailButton.layer.shadowOpacity = 0.1
                  detailButton.layer.shadowRadius = 8// 퍼지는 정도
                  detailButton.layer.cornerRadius = 14
     }
    
    
    // page 형태를 주기 위해
    private func configureScrollView(){
        homeListCollectionView.contentSize = CGSize(width: view.frame.size.width*CGFloat(page), height: homeListCollectionView.frame.size.height)
        
        homeListCollectionView.isPagingEnabled = true
    }
}


// MARK: UICollectionView DataSource
extension HomeNewVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return page
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeNewCVCell", for: indexPath)
   
        print("indexpath값은? -> \(indexPath.row)")
        
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
        print("\(curentpage)")

    }
    
}

//  MARK: sideMenu 만든 Delegate
extension HomeNewVC : UIViewControllerTransitioningDelegate{
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = true
//        return transition
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = false
//        return transition
//    }
}

