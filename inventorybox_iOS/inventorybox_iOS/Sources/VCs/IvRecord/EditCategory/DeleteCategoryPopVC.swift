//
//  DeleteCategoryPopVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class DeleteCategoryPopVC: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories = [CategoryInfo]()
    var categoryToDelete = [Int]()
    
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
        NotificationCenter.default.post(name: .init("popupFromDeleteCateToEditCate"),  object: self, userInfo: ["categoryToDelete": categoryToDelete])
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension DeleteCategoryPopVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: DeleteCategoryCell.identifier, for: indexPath) as? DeleteCategoryCell else { return UITableViewCell() }
        categoryCell.delegate = self
        categoryCell.setCellInformation(categoryInfo: categories[indexPath.row].name)
        categoryCell.isWhole = 0 == indexPath.row
        categoryCell.indexpath = indexPath.row
        categoryCell.categoryIdx = categories[indexPath.row].categoryIdx
        return categoryCell
    }
    
}

extension DeleteCategoryPopVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension DeleteCategoryPopVC: CategoryButtonDelegate {
    func didDeleteCategoryBtnPressed(categoryName: String, indexPath: Int, idx: Int) {
        
        IvRecordDeleteCateService.shared.deleteCate(idx: idx) { (networkResult) in
            switch networkResult {
            case .success(let data):
                print(data)
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
        categoryToDelete.append(idx)
        if categories.contains(where: { (category) -> Bool in
            return category.categoryIdx == idx
        }) {
            let index = categories.firstIndex { (category) -> Bool in
                return category.categoryIdx == idx
            }
            if let i = index {
                categories.remove(at: i)
            }
        }
        categoryTableView.reloadData()
    }
}
