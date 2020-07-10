//
//  IvRecordCategoryEditVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView
import BEMCheckBox
class IvRecordCategoryEditVC: UIViewController {
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var categoryEditTableView: UITableView!
    
    @IBOutlet var bottomView: [UIView]!

    @IBOutlet weak var popupBackgroundView: UIView!
    
    let categoryCollectionView = TTGTextTagCollectionView()
    private var selections = [String]()
    private var checkboxSelections = [IndexPath]()
    
    var inventoryEditArray: [InventoryEditInformation] = {
        
        let data1 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5", unit: "팩", categoryNum: "액체류",select: false)
        let data2 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10", unit: "팩",  categoryNum: "액체류", select: false)
        let data3 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",   categoryNum: "과일", select: false)
        let data4 = InventoryEditInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "통",  categoryNum: "파우더류", select: false)
        let data5 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        let data6 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        let data7 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "우유",  mInventory: "10", unit: "팩",  categoryNum: "액체류", select: false)
        let data8 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "녹차 파우더",  mInventory: "10", unit: "팩",  categoryNum: "파우더류", select: false)
        let data9 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",  categoryNum: "과일", select: false)
        let data10 = InventoryEditInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "팩",  categoryNum: "액체류", select: false)
        let data11 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        let data12 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
        
    }()
    
    private var inventoryFilteredArray: [InventoryEditInformation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setInventoryFilteredData()
        addCategoryCollectionView()
        setShadowUnderOutView()
        setCategoryEditTableView()
        setViewCustom()
        setPopupBackgroundView()
    }
    
    private func setInventoryFilteredData() {
        inventoryFilteredArray = inventoryEditArray
    }
    private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
        
    }
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let name = info["categoryName"] as? String else { return }
        print(name)
        CategoryInformation.categories.append(name)
        print(CategoryInformation.categories)
        //        categoryCollectionView.reload()
        if name != "none" {
            categoryCollectionView.addTags([name], with: categoryCollectionView.setCategoryConfig())
        }
        
        animatePopupBackground(false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func addCategoryBtnPressed(_ sender: Any) {
        animatePopupBackground(true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddCategoryPopupVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    private func setViewCustom() {
        for view in bottomView {
            view.backgroundColor = UIColor.yellow
        }
    }
    
    private func setCategoryEditTableView() {
        
        categoryEditTableView.delegate = self
        categoryEditTableView.dataSource = self
        
        categoryEditTableView.allowsSelection = false
        categoryEditTableView.separatorStyle = .none
        
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
        
        categoryCollectionView.addTags(CategoryInformation.categories, with: categoryCollectionView.setCategoryConfig())
        
        
    }
    
}

//MARK: - categoryEditTableView

extension IvRecordCategoryEditVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryFilteredArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: SelectHeaderCell.identifier, for: indexPath) as? SelectHeaderCell else { return UITableViewCell() }

            headerCell.delegate = self
            headerCell.indexPath = indexPath
            
            return headerCell
            
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCategoryEditCell.identifier, for: indexPath) as? InventoryCategoryEditCell else { return UITableViewCell() }
            
            inventoryCell.delegate = self
            inventoryCell.indexPath = indexPath
            inventoryCell.isSelectBtn = self.checkboxSelections.contains(indexPath)
            
            inventoryCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].inventoryImageName, inventoryFilteredArray[indexPath.row - 1].inventoryName, inventoryFilteredArray[indexPath.row - 1].minimumInventory, checkboxSelected: inventoryFilteredArray[indexPath.row - 1].isSelected)
            
            
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
    //    var rowsWhichAreChecked = [NSIndexPath]()
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell: InventoryCategoryEditCell = tableView.cellForRow(at: indexPath) as! InventoryCategoryEditCell
    //
    //        if rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false {
    //            cell.selectedCheckBox.on = true
    //            rowsWhichAreChecked.append(indexPath as NSIndexPath)
    //        }
    //        else{
    //           cell.selectedCheckBox.on = false
    //           // remove the indexPath from rowsWhichAreCheckedArray
    //           if let checkedItemIndex = rowsWhichAreChecked.indexOf(indexPath){
    //              rowsWhichAreChecked.removeAtIndex(checkedItemIndex)
    //           }
    //        }
    
    //    }
}
//MARK: - categoryCell
extension IvRecordCategoryEditVC: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
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
                inventoryFilteredArray = inventoryEditArray
                categoryEditTableView.reloadData()
            }
        }
        if !allCategoryCheck {
            inventoryFilteredArray = []
            for i in 0..<selections.count {
                let filterred = inventoryEditArray.filter { (inventory) -> Bool in
                    return inventory.category == selections[i]
                }
                
                for data in filterred {
                    inventoryFilteredArray.append(data)
                }
            }
            categoryEditTableView.reloadData()
        }
    }
}

extension IvRecordCategoryEditVC: CellButtonDelegate {
    func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: IndexPath) {
        print("allTap")
        for i in 0..<inventoryFilteredArray.count {
            if isClicked {
                inventoryFilteredArray[i].isSelected = true
                if self.checkboxSelections.contains(indexPath) {
                    guard let i = self.checkboxSelections.firstIndex(of: indexPath) else { return }
                    self.checkboxSelections.remove(at: i)
                } else {
                    checkboxSelections.append(indexPath)
                }
                
            } else {
                inventoryFilteredArray[i].isSelected = false
                checkboxSelections = []
            }
            
            
            categoryEditTableView.reloadData()
            
        }
    
    }
    
    func didClickCheckButton(isClicked: Bool, indexPath: IndexPath) {
        inventoryFilteredArray[indexPath.row].isSelected = isClicked
        
        if self.checkboxSelections.contains(indexPath) {
            guard let i = self.checkboxSelections.firstIndex(of: indexPath) else { return }
            self.checkboxSelections.remove(at: i)
        } else {
            
            checkboxSelections.append(indexPath)
        }
        
    }
    
}
