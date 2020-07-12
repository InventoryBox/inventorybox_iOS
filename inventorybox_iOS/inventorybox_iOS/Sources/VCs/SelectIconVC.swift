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
        
        navigationController?.navigationItem.backBarButtonItem?.title = ""
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
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setIconCollectionView()
        
    }
    
    private func setIconCollectionView() {
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
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
        
        iconCell.
    }
    
    
}

extension SelectIconVC: UICollectionViewDelegateFlowLayout {
    
}
