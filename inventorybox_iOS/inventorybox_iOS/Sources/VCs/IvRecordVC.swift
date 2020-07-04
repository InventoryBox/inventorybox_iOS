//
//  IvRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/02.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvRecordVC: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let categoryArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//MARK: - CollectionView
extension IvRecordVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell.identifier, for: indexPath) as? MusicCell else { return UICollectionViewCell() }
        
        
        
        
        
    }
}

extension IvRecordVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
}
