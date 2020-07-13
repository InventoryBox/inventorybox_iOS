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
    private var checkboxSelections = [Int]()
    
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
    
    var inventoryEditArray: [InventoryEditCategoryInformation] = {
        
        let data1 = InventoryEditCategoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5", unit: "팩", categoryNum: "액체류",select: false)
        let data2 = InventoryEditCategoryInformation(imageName: "homeIcMcpowder", ivName: "녹차 파우더", mInventory: "10", unit: "팩",  categoryNum: "파우더류", select: false)
        let data3 = InventoryEditCategoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",   categoryNum: "과일", select: false)
        let data4 = InventoryEditCategoryInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "통",  categoryNum: "파우더류", select: false)
        let data5 = InventoryEditCategoryInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        let data6 = InventoryEditCategoryInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        let data7 = InventoryEditCategoryInformation(imageName: "homeIcMilk", ivName: "우유",  mInventory: "10", unit: "팩",  categoryNum: "액체류", select: false)
        let data8 = InventoryEditCategoryInformation(imageName: "homeIcMcpowder", ivName: "녹차 파우더",  mInventory: "10", unit: "팩",  categoryNum: "파우더류", select: false)
        let data9 = InventoryEditCategoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",  categoryNum: "과일", select: false)
        let data10 = InventoryEditCategoryInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "팩",  categoryNum: "액체류", select: false)
        let data11 = InventoryEditCategoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        let data12 = InventoryEditCategoryInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일", select: false)
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
        
    }()
    
    private var inventoryFilteredArray: [InventoryEditCategoryInformation] = []
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(whenCategoryMovePopupDismiss), name: .init("categoryPopup"), object: nil)
    }
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
    }
    
    @objc func whenCategoryMovePopupDismiss(_ notification: Notification) {

        animatePopupBackground(false)
        
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let name = info["categoryName"] as? String else { return }
        
        print(name)
//        inventoryEditArray[indexPath].category = name
        
        for i in 0..<inventoryEditArray.count {
            if inventoryEditArray[i].isSelected {
                inventoryEditArray[i].category = name
            }
        }
        
        for i in 0..<inventoryFilteredArray.count {
            if inventoryFilteredArray[i].isSelected {
                inventoryFilteredArray[i].category = name
            }
        }
        
        print(inventoryEditArray)
        categoryEditTableView.reloadData()
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let name = info["categoryName"] as? String else { return }
        print(name)
        categories.append(name)
        print(categories)
        //        categoryCollectionView.reload()
        if name != "none" {
            categoryCollectionView.addTags([name], with: categoryCollectionView.setCategoryConfig())
        }
        
        animatePopupBackground(false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func deleteInventoryBtnPressed(_ sender: Any) {
        // 선택된 재료 삭제하기 서버 반영 버튼
    
        
    }
    
    @IBAction func moveCategoryBtnPressed(_ sender: Any) {
        animatePopupBackground(true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MoveCategoryPopupVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
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
        
        categoryCollectionView.addTags(categories, with: categoryCollectionView.setCategoryConfig())
        
        
    }
    
}

//MARK: - categoryEditTableView

extension IvRecordCategoryEditVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryFilteredArray.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: SelectHeaderCell.identifier, for: indexPath) as? SelectHeaderCell else { return UITableViewCell() }
            
            headerCell.delegate = self
            headerCell.indexPath = indexPath.row
            
            return headerCell
            
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCategoryEditCell.identifier, for: indexPath) as? InventoryCategoryEditCell else { return UITableViewCell() }
            
            inventoryCell.delegate = self
            inventoryCell.indexPath = indexPath.row - 1
            inventoryCell.isSelectBtn = self.checkboxSelections.contains(indexPath.row - 1)
            
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

//MARK: - CellButtonDelegate

extension IvRecordCategoryEditVC: CellButtonDelegate {
    func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: Int) {
        
        print("allTap")
        for i in 0..<inventoryFilteredArray.count {
            if isClicked {
                inventoryFilteredArray[i].isSelected = true
                if self.checkboxSelections.contains(i) {
                    guard let index = self.checkboxSelections.firstIndex(of: i) else { return }
                    self.checkboxSelections.remove(at: index)
                } else {
                    checkboxSelections.append(i)
                }
                
            } else {
                inventoryFilteredArray[i].isSelected = false
                checkboxSelections = []
            }
            
        }
        print(inventoryFilteredArray)
        categoryEditTableView.reloadData()
        
        // 전체 데이터 동기화
        for i in 0..<inventoryEditArray.count {
            if isClicked {
                inventoryEditArray[i].isSelected = true
            } else {
                inventoryEditArray[i].isSelected = false
            }
        }
    }
    
    func didClickCheckButton(isClicked: Bool, indexPath: Int) {
        
        inventoryFilteredArray[indexPath].isSelected = isClicked
        
        if self.checkboxSelections.contains(indexPath) {
            guard let i = self.checkboxSelections.firstIndex(of: indexPath) else { return }
            self.checkboxSelections.remove(at: i)
        } else {
            checkboxSelections.append(indexPath)
        }
        
        print(inventoryFilteredArray)
        
        // 전체 데이터 동기화
        inventoryEditArray[indexPath].isSelected = isClicked
        }
    
}
