//
//  SelectCategoryVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SelectCategoryVC: UIViewController {
    
    let whichCategorySelected: [Int] = [0]
    
    @IBOutlet weak var selectTableView: UITableView!
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectTableView()
        
    }
    private func getDataFromServer() {
        
//        IvRecord.shared.getRecordAddIv() { (networkResult) in
//            switch networkResult {
//            case .success(let data):
//                guard let dt = data as? AddIvClass else { return }
//
//                self.iconArray = dt.iconInfo
//                self.categories = dt.categoryInfo
//
//            case .requestErr(let message):
//                guard let message = message as? String else { return }
//                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
//                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
//                alertViewController.addAction(action)
//                self.present(alertViewController, animated: true, completion: nil)
//
//            case .pathErr: print("path")
//            case .serverErr: print("serverErr")
//            case .networkFail: print("networkFail")
//            }
//        }
        
    }
    private func setSelectTableView() {
        selectTableView.delegate = self
        selectTableView.dataSource = self
    }
    @IBAction func dismissBtnPressed(_ sender: Any) {
        
        NotificationCenter.default.post(name: .init("popup"), object: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SelectCategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryCell.identifier, for: indexPath) as? SelectCategoryCell else { return UITableViewCell() }
        categoryCell.delegate = self
        categoryCell.indexpath = indexPath.row
        categoryCell.setCellInformation(categoryInfo: categories[indexPath.row])
        categoryCell.isWhole = whichCategorySelected.contains(indexPath.row)
        
        return categoryCell
        
    }
    
    
}

extension SelectCategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
        
    }
    
    
}

extension SelectCategoryVC: CategoryButtonDelegate {
    
    func didSelectCategory(categoryName: String, indexPath: Int) {
//        print("Tap")
        print(categoryName)
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["categoryName": categoryName])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
