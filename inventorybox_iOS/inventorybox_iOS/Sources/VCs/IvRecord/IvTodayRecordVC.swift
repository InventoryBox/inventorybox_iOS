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
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayDateLable: UILabel!
    @IBOutlet weak var inventoryTodayRecordTableView: UITableView!
    @IBOutlet weak var completeBtn: UIButton!
    
    var textFieldBox: [IndexPath] = []
    
    let inventoryTodayArray: [InventoryTodayInformation] = {
        let data1 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data2 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data3 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data4 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data5 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data6 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data7 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data8 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        let data9 = InventoryTodayInformation(imageName: "homeIcMilk", ivName: "우유", categoryNum: "액체류", isTyped: false)
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9]
    }()
    
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
        
    }
}

//MARK: - TagCollectionView

extension IvTodayRecordVC: TTGTextTagCollectionViewDelegate {

}

//MARK: - InventoryEditTableView
extension IvTodayRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryTodayArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            
            guard let inventoryTodayRecordCell = tableView.dequeueReusableCell(withIdentifier: InventoryTodayRecordCell.identifier, for: indexPath) as? InventoryTodayRecordCell else { return UITableViewCell() }
            
            inventoryTodayRecordCell.indexPath = indexPath
            inventoryTodayRecordCell.delegate = self

            
            inventoryTodayRecordCell.setInventoryData(inventoryTodayArray[indexPath.row - 1].inventoryImageName, inventoryTodayArray[indexPath.row - 1].inventoryName, inventoryCount: inventoryTodayArray[indexPath.row - 1].inventoryCount )
            
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

//MARK: - FilledTextFieldDelegate

extension IvTodayRecordVC: FilledTextFieldDelegate {
    func isTextFieldFilled(count: String,  isTyped: Bool, indexPath: IndexPath) {
        if self.textFieldBox.contains(indexPath) {
            if !isTyped {
                guard let i = self.textFieldBox.firstIndex(of: indexPath) else { return }
                self.textFieldBox.remove(at: i)
            }
        } else {
            if isTyped {
                textFieldBox.append(indexPath)
            }
            
        }
        
        if inventoryTodayArray.count == textFieldBox.count {
            completeBtn.backgroundColor = UIColor.yellow
            completeBtn.tintColor = UIColor.white
            completeBtn.isEnabled = true
        }
    }
}

