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
    }
    private func setCategoryTableView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.allowsSelection = false
        categoryTableView.separatorStyle = .none
    }
    @IBAction func backBtn(_ sender: Any) {
        let notiName = Notification.Name(rawValue: "name")
        NotificationCenter.default.post(name: notiName, object: nil)
        NotificationCenter.default.post(name: .init("categoryPopup"), object: nil)
        self.presentingViewController?.dismiss(animated: true, completion: {
            let secondPVC = self.presentingViewController?.presentingViewController
            secondPVC?.dismiss(animated: true, completion: nil)
        })
        
    }
    
    @IBAction func dismissPopupView(_ sender: Any) {
        // 서버 반영 코드
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MoveCategoryPopupVC") else { return }
        let notiName = Notification.Name(rawValue: "name")
        NotificationCenter.default.post(name: notiName, object: nil)
        
        self.presentingViewController?.dismiss(animated: true, completion: {
            let secondPVC = self.presentingViewController?.presentingViewController
            secondPVC?.dismiss(animated: true, completion: nil)
        })
//        self.dismiss(animated: false) {
//            print("dismiss ")
//            guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "MoveCategoryPopupVC") as? MoveCategoryPopupVC else { return }
//            secondVC.dismiss(animated: false, completion: nil)
//        }
    }
}
extension DeleteCategoryPopVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: DeleteCategoryCell.identifier, for: indexPath) as? DeleteCategoryCell else { return UITableViewCell() }
                
                categoryCell.delegate = self
                categoryCell.setCellInformation(categoryInfo: categories[indexPath.row])
                categoryCell.isWhole = self.whichCategorySelected.contains(indexPath.row)
                categoryCell.indexpath = indexPath.row
                
        //            print(self.whichCategorySelected.contains(indexPath.row))

                return categoryCell
    }
    
    
}

extension DeleteCategoryPopVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
        
    }
}

extension DeleteCategoryPopVC: CategoryButtonDelegate {
    func didDeleteCategoryBtnPrssed(categoryName: String, indexPath: Int) {
        print("tap")
        print(categoryName)
        print(indexPath)
        
        if self.categories.contains(categoryName) {
            guard let i = self.categories.firstIndex(of: categoryName) else { return }
            self.categories.remove(at: i)
        }
        categoryTableView.reloadData()
    }
}
