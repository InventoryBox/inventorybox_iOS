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
    
    let whichCategorySelected: [Int] = [0]
    
    var categories: [CategoryInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromServer()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.allowsSelection = false
        categoryTableView.separatorStyle = .none
        
    }
    
    private func getDataFromServer() {
        
        CategoryService.shared.getCategory() { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? CategoryClass else { return }
                self.categories = dt.categoryInfo
                self.categoryTableView.reloadData()
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)

            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .init("popupFromMoveCateToEditCate"), object: nil)
        self.dismiss(animated: false, completion: nil)
    }
}

extension MoveCategoryPopupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MoveCategoryCell.identifier, for: indexPath) as? MoveCategoryCell else { return UITableViewCell() }
        
        categoryCell.delegate = self
        categoryCell.setCellInformation(categoryInfo: categories[indexPath.row].name, idx: categories[indexPath.row].categoryIdx)
        categoryCell.isWhole = self.whichCategorySelected.contains(indexPath.row)
        
        return categoryCell
        
    }
    
    
}
extension MoveCategoryPopupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension MoveCategoryPopupVC: CategoryButtonDelegate {
    func didSelectCategory(categoryName: String, idx: Int) {
        NotificationCenter.default.post(name: .init("popupFromMoveCateToEditCate"), object: nil, userInfo: ["moveCategoryIdx": idx])
        self.dismiss(animated: true, completion: nil)
    }
}
