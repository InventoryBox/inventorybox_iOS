//
//  SettingDetailVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/09/20.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SettingDetailVC: UIViewController {
    static let identifier: String = "SettingDetailVC"
    
    var navigationTitle: String?
    var whichInformation: Int?
    let menuArray: [String] = ["기본", "재고기록", "발주 알림", "재고량 추이", "재고교환"]
    @IBOutlet weak var userTermScrollView: UIScrollView!
    @IBOutlet weak var privacyPolicyScrollView: UIScrollView!
    @IBOutlet weak var locationTermScrollView: UIScrollView!
    @IBOutlet weak var inventoryBoxInstructionScrollView: UIScrollView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.tintColor = .yellow
        self.navigationController?.navigationBar.topItem?.title = ""
        //출처: https://zeddios.tistory.com/29 [ZeddiOS]
        
        if let indexPath = whichInformation {
            showInformation(by: indexPath)
        }
        
    }
    
    private func showInformation(by indexPath: Int) {
        userTermScrollView.isHidden = indexPath == 0 ? false : true
        privacyPolicyScrollView.isHidden = indexPath == 1 ? false : true
        locationTermScrollView.isHidden = indexPath == 2 ? false : true
        inventoryBoxInstructionScrollView.isHidden = indexPath == 3 ? false : true
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()

        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
    }
    
}

extension SettingDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
    }
}

extension SettingDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        menuCell.set(title: menuArray[indexPath.row])
        return menuCell
    }
    
}
