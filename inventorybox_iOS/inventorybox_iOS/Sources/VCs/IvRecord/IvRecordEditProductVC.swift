//
//  IvRecordEditProductVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class IvRecordEditProductVC: UIViewController {

    let categoryCollectionView = TTGTextTagCollectionView()
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var inventoryEditPrdoctTableView: UITableView!
    
    @IBOutlet weak var completeBtn: UIButton!
    
    var textFieldBox: [Int] = []
    
    var inventoryEditProductArray: [InventoryEditProductInformation] = {
        let data1 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data2 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data3 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data4 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data5 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data6 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data7 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data8 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        let data9 = InventoryEditProductInformation(imageName: "homeIcMilk", ivName: "우유", category: "액체류", count: "30")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9]
    }()
    
    private var selections = [String]()
    
    private var inventoryFilteredArray: [InventoryEditProductInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInventoryFilteredData()
        customCompleteBtn()
        setinventoryEditPrdoctTableViewTableView()
        makeShadowUnderOutView()
        addCategoryCollectionView()
    }

    private func setInventoryFilteredData() {
        inventoryFilteredArray = inventoryEditProductArray
    }
    
    private func customCompleteBtn() {
        
        completeBtn.layer.cornerRadius = 25
        completeBtn.backgroundColor = UIColor.yellow
        completeBtn.tintColor = UIColor.white
        completeBtn.isEnabled = true
        
    }
    
    private func setinventoryEditPrdoctTableViewTableView() {
        
        inventoryEditPrdoctTableView.delegate = self
        inventoryEditPrdoctTableView.dataSource = self
        
        inventoryEditPrdoctTableView.allowsSelection = false
        inventoryEditPrdoctTableView.separatorStyle = .none
        
    }
    
    private func makeShadowUnderOutView() {
        
        self.outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.outView.layer.shadowOpacity = 0.05
        self.outView.layer.shadowRadius = 2
        
    }
    
    private func addCategoryCollectionView() {
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.setCategoryCollectionView()
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        categoryCollectionView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 8).isActive = true
        
        categoryCollectionView.addTags(["전체", "액체류","파우더류", "과일", "채소류"], with: categoryCollectionView.setCategoryConfig())
        
    }
    @IBAction func goToAddProductVC(_ sender: Any) {
        let IvRecordAddProductST = UIStoryboard.init(name: "IvRecordAddProduct", bundle: nil)
        guard let addProductVC = IvRecordAddProductST.instantiateViewController(identifier: "IvRecordNaviVC")
            as? IvRecordNaviVC  else {
                return
        }
        addProductVC.modalPresentationStyle = .fullScreen
        
        self.present(addProductVC, animated: true, completion: nil)
    }
    @IBAction func completeBtnPressed(_ sender: Any) {
        
        // 서버 통신 코드
        
        self.dismiss(animated: false, completion: nil)
    }
}

//MARK: - TagCollectionView
extension IvRecordEditProductVC: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        // 한개만 선택되게 만드는 코드
        // 카테고리 전체 어떻게 할것인가?
        
        
        // selection 배열 내에 한개씩만 선택되게 만들기
        var check = 0
        for i in 0..<selections.count {
            if selections[i] == tagText {
                check = 1
                selections.remove(at: i)
                break
            }
        }
        
        if check == 0 {
            selections.append(tagText)
        }
        
        // 카테고리 필터링 코드
        var allCategoryCheck: Bool = false
        
        for i in 0..<selections.count {
            if selections[i] == "전체" {
                allCategoryCheck = true
                inventoryFilteredArray = inventoryEditProductArray
                inventoryEditPrdoctTableView.reloadData()
            }
        }
        
        if !allCategoryCheck {
            inventoryFilteredArray = []
            for i in 0..<selections.count {
                let filterred = inventoryEditProductArray.filter { (inventory) -> Bool in
                    return inventory.category == selections[i]
                }
                
                for data in filterred {
                    inventoryFilteredArray.append(data)
                }
            }
            inventoryEditPrdoctTableView.reloadData()
        }
        
    }
}

//MARK: - TableView
//MARK: - InventoryEditTableView
extension IvRecordEditProductVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryFilteredArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            
            guard let inventoryTodayRecordCell = tableView.dequeueReusableCell(withIdentifier: InventoryEditProductCell.identifier, for: indexPath) as? InventoryEditProductCell else { return UITableViewCell() }
            
            inventoryTodayRecordCell.indexPath = indexPath.row - 1
            inventoryTodayRecordCell.delegate = self
            
            
            inventoryTodayRecordCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].inventoryImageName, inventoryFilteredArray[indexPath.row - 1].inventoryName, inventoryFilteredArray[indexPath.row - 1].inventoryCount)
            
            return inventoryTodayRecordCell
            
        }
    }
}

extension IvRecordEditProductVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 35
            
        } else {
            
            return 102
            
        }
        
    }
}


extension IvRecordEditProductVC: FilledTextFieldDelegate {
    func isTextFieldFilled(count: String,  isTyped: Bool, indexPath: Int) {
        
        
        inventoryEditProductArray[indexPath].inventoryCount = count
        
        inventoryFilteredArray = inventoryEditProductArray
        
        
    }
}
