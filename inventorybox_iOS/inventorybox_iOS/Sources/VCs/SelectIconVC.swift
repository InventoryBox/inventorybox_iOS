//
//  SelectIconVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SelectIconVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        let naviBar = navigationController?.navigationBar
        naviBar?.layer.shadowOffset = CGSize(width: 0, height: 1)
        naviBar?.layer.shadowRadius = 2
        naviBar?.layer.shadowOpacity = 0.16
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
    @IBOutlet weak var iconCollectionView: UICollectionView!
    
    var icon: [String] = [
        "homeIcMilk", "homeIcMilk", "homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk",
        "homeIcMilk", "homeIcMilk", "homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk",
        "homeIcMilk", "homeIcMilk", "homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk",
        "homeIcMilk", "homeIcMilk", "homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk",
        "homeIcMilk", "homeIcMilk", "homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk","homeIcMilk",
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIconCollectionView()
        setShadow()
    }
    
    private func setShadow() {
        
    }
    
    private func setIconCollectionView() {
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
        
        iconCollectionView.allowsSelection = false

    }
    
    @IBAction func sendIdx(_ sender: UIButton) {
        guard let idx = sender.currentTitle else {
            return
        }
        NotificationCenter.default.post(name: .init("iconIdx"), object: nil, userInfo: ["selectedIdx": idx])
        self.dismiss(animated: true)
    }
}

extension SelectIconVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as? IconCell else { return UICollectionViewCell() }
        
        
        iconCell.delegate = self
        iconCell.indexPath = indexPath.row
        iconCell.setIcon(icon[indexPath.row])
        
        return iconCell
    }
    
    
}


extension SelectIconVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width-55) / 4, height: 80)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 14, left: 16, bottom: 0, right: 16)
        
    }
    // 위아래
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
        
    }
    // 양옆
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
        
    }
}

extension SelectIconVC: IconSeletDelegate {
    func didSelectIcon(indexPath: Int, iconImageName: String) {
        print("Tap")
        self.navigationController?.popViewController(animated: true)
    }
}
