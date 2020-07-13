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
    
    var categories: [String] = {
        let data1 = CategoryInformation(idx: 1, name: "전체")
        let data2 = CategoryInformation(idx: 2, name: "액체류")
        let data3 = CategoryInformation(idx: 3, name: "파우더류")
        let data4 = CategoryInformation(idx: 4, name: "과일")
        let data5 = CategoryInformation(idx: 5, name: "채소류")
        let data6 = CategoryInformation(idx: 6, name: "스파게티 재료들")
        let data7 = CategoryInformation(idx: 7, name: "아침마다 확인해야 할 것들")
        
        return [data1.categoryName, data2.categoryName, data3.categoryName, data4.categoryName, data5.categoryName, data6.categoryName, data7.categoryName]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCategoryTableView()
        addObserver()
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
        categoryCell.setCellInformation(categoryInfo: categories[indexPath.row])
        categoryCell.isWhole = self.whichCategorySelected.contains(indexPath.row)
        categoryCell.indexpath = indexPath.row
        
        //            print(self.whichCategorySelected.contains(indexPath.row))
        
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
