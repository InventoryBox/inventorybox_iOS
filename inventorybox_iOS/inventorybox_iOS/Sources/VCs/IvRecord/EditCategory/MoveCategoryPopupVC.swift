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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCategoryTableView()
        addObserver()
        
    }
    
    private func getDataFromServer() {
        
        CategoryService.shared.getCategory() { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? CategoryClass else { return }
                print(dt)

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
    func addObserver() {
        
        let notiName = Notification.Name(rawValue: "name")
        NotificationCenter.default.addObserver(self, selector: #selector(dismissVC), name: notiName, object: nil)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .init("categoryPopup"), object: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissVC() {
        
        NotificationCenter.default.post(name: .init("categoryPopup"), object: nil)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func goToDeletePopVC(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteCategoryPopVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
        
        removeFromParent()
    }
    private func setCategoryTableView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.allowsSelection = false
        categoryTableView.separatorStyle = .none
    }
    
    
}

extension MoveCategoryPopupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MoveCategoryCell.identifier, for: indexPath) as? MoveCategoryCell else { return UITableViewCell() }
        
        categoryCell.delegate = self
        categoryCell.setCellInformation(categoryInfo: categories[indexPath.row].name)
        categoryCell.isWhole = self.whichCategorySelected.contains(indexPath.row)
        categoryCell.indexpath = indexPath.row
        
        return categoryCell
        
    }
    
    
}
extension MoveCategoryPopupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
        
    }
    
    
}

extension MoveCategoryPopupVC: CategoryButtonDelegate {
    func didSelectCategory(categoryName: String, indexPath: Int) {
        print("Tap")
        print(categoryName)
        NotificationCenter.default.post(name: .init("categoryPopup"), object: nil, userInfo: ["categoryName": categoryName])
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
