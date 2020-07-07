//
//  IvRecordCategoryEditVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class IvRecordCategoryEditVC: UIViewController {
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var categoryEditTableView: UITableView!
    
    let categoryCollectionView = TTGTextTagCollectionView()
    private var selections = [String]()
    var inventoryArray: [InventoryInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCategoryCollectionView()
        setShadowUnderOutView()
        setCompleteBtn()
        setTodayDateLabel()
        setCategoryEditTableView()
        setInventoryData()
        
    }
    
    
    @IBAction func completeBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    private func setCategoryEditTableView() {
        
        categoryEditTableView.delegate = self
        categoryEditTableView.dataSource = self
        
        categoryEditTableView.allowsSelection = false
        categoryEditTableView.separatorStyle = .none
        
    }
    private func setCompleteBtn() {
        
        completeBtn.backgroundColor = UIColor.yellow
        completeBtn.layer.cornerRadius = 10
        completeBtn.tintColor = UIColor.white
        
    }
    
    private func setTodayDateLabel() {
        
        self.todayDateLabel.text = "2020.06.27 토요일"
        
    }
    private func setShadowUnderOutView() {
        
        self.outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.outView.layer.shadowOpacity = 0.05
        
    }
    private func addCategoryCollectionView() {
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.setCategoryCollectionView()
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        categoryCollectionView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 8).isActive = true
        
        categoryCollectionView.addTags(["전체", "액체류",], with: categoryCollectionView.setCategoryConfig())
        
    }
    private func setInventoryData() {
        let data1 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data2 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data3 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data4 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data5 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data6 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data7 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data8 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data9 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data10 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        
        inventoryArray = [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10]
        
    }
}

//MARK: - categoryEditTableView

extension IvRecordCategoryEditVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCategoryEditCell.identifier, for: indexPath) as? InventoryCategoryEditCell else { return UITableViewCell() }
            
            inventoryCell.setInventoryData(inventoryArray[indexPath.row - 1].inventoryImageName, inventoryArray[indexPath.row - 1].inventoryName, inventoryArray[indexPath.row - 1].minimumInventory)
            
            return inventoryCell
            
        }
        
        
    }
    
    
}

extension IvRecordCategoryEditVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 35
            
        } else {
            
            return 102
            
        }
        
    }
}
//MARK: - categoryCell
extension IvRecordCategoryEditVC: TTGTextTagCollectionViewDelegate {
    
}
