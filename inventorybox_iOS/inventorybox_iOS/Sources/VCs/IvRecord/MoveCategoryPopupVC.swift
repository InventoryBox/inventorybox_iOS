//
//  MoveCategoryPopupVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class MoveCategoryPopupVC: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var whichCategorySelected: [Int] = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setRoundView()
        setCategoryTableView()
        
    }
    
    
    private func setCategoryTableView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.allowsSelection = false
        categoryTableView.separatorStyle = .none
    }
//    
//    private func setRoundView() {
//        
//        roundView.layer.cornerRadius = 8
//        roundView.layer.borderWidth = 1.3
//        
//    }
    

}

extension MoveCategoryPopupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryInformation.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MoveCategoryCell.identifier, for: indexPath) as? MoveCategoryCell else { return UITableViewCell() }
        
        categoryCell.setCellInformation(categoryInfo: CategoryInformation.categories[indexPath.row])
        categoryCell.isWhole = self.whichCategorySelected.contains(indexPath.row)
            
            print(self.whichCategorySelected.contains(indexPath.row))
//        print(indexPath.row)
        return categoryCell
    }
    
    
}
extension MoveCategoryPopupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
    
    
}

extension MoveCategoryPopupVC: CategoryButtonDelegate {
    func didSelectCategory(indexPath: Int) {
        
    }
    
    
}
