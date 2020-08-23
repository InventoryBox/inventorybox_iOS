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

    var page : Int = 2      // page 개수 관련 변수
    var curentpage : Int = 0
    
    let setInformations : [Int] = [1,2,3,4,5,6,7,2,13,5,2,1,2,3,15,2,23,1,2,2,3,1,2,5,2,1,2,3,51,2,5,2,1,5,2,1,2,3,4,1,25,2]

    override func viewDidLoad() {
        super.viewDidLoad()

        homeListCollectionView.dataSource = self
        homeListCollectionView.delegate = self
        
        pages()
        configureScrollView()   //
       
    }
    
    func pages() {
        page = 1 + setInformations.count / 15         // 15로 나눴을 때
        pageControl.numberOfPages = page    // pagecontrol의 점 개수
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
   
        
        return listCell
    }
    
    
}

// MARK: UICollectionView Delegate
extension HomeNewVC: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        curentpage =  Int(floorf(Float(homeListCollectionView.contentOffset.x)/Float(homeListCollectionView.frame.size.width)))
        
        pageControl.currentPage = curentpage
        print("\(curentpage)")
        
    }
}
