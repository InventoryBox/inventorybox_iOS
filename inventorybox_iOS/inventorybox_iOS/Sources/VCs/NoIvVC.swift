//
//  NoIvVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class NoIvVC: UIViewController {

    let categoryCollectionView = TTGTextTagCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCategoryCollectionView()
    
    }
    
    private func addCategoryCollectionView() {
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.setCategoryCollectionView()
        categoryCollectionView.addTags(["전체", "액체류",], with: categoryCollectionView.setCategoryConfig())
        
    }
}

extension NoIvVC: TTGTextTagCollectionViewDelegate {
    
}
