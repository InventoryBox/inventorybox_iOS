//
//  IvTodayRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class IvTodayRecordVC: UIViewController {

    let categoryCollectionView = TTGTextTagCollectionView()
    private var selections = [String]()
    var inventoryArray: [InventoryData] = []
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayDateLable: UILabel!
    @IBOutlet weak var inventoryTodayRecordTableView: UITableView!
    @IBOutlet weak var completeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCategoryCollectionView()
        makeShadowUnderOutView()
        setInventoryTodayRecordTableView()
        customCompleteBtn()
        setInventoryData()
    }
    
    private func customCompleteBtn() {
        
        completeBtn.layer.cornerRadius = 25
        completeBtn.backgroundColor = UIColor.pinkishGrey
        completeBtn.tintColor = UIColor.white
        completeBtn.isEnabled = false
        
    }
    
    private func setInventoryTodayRecordTableView() {
        
        inventoryTodayRecordTableView.delegate = self
        inventoryTodayRecordTableView.dataSource = self
        
        inventoryTodayRecordTableView.allowsSelection = false
        inventoryTodayRecordTableView.separatorStyle = .none
    
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
    private func setInventoryData() {
        let data1 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data2 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data3 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data4 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data5 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        
        inventoryArray = [data1, data2, data3, data4, data5]
    }
}

//MARK: - TagCollectionView

extension IvTodayRecordVC: TTGTextTagCollectionViewDelegate {

}

//MARK: - InventoryEditTableView

extension IvTodayRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            
            guard let inventoryTodayRecordCell = tableView.dequeueReusableCell(withIdentifier: InventoryTodayRecordCell.identifier, for: indexPath) as? InventoryTodayRecordCell else { return UITableViewCell() }
            
            inventoryTodayRecordCell.setInventoryData(inventoryArray[indexPath.row - 1].inventoryImageName, inventoryArray[indexPath.row - 1].inventoryName)
            
            return inventoryTodayRecordCell
            
        }
    }
}

extension IvTodayRecordVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 35
            
        } else {
            
            return 102
            
        }
        
    }
}
