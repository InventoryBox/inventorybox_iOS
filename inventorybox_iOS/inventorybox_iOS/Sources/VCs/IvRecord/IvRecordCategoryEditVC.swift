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
    
    
    private var inventoryFiltered: [InventoryEditInformation] = InventoryEditInformation.inventoryEditArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCategoryCollectionView()
        setShadowUnderOutView()
        setCategoryEditTableView()
        setViewCustom()
        setPopupBackgroundView()
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
        
        return inventoryFiltered.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCategoryEditCell.identifier, for: indexPath) as? InventoryCategoryEditCell else { return UITableViewCell() }
            
            inventoryCell.setInventoryData(inventoryFiltered[indexPath.row - 1].inventoryImageName, inventoryFiltered[indexPath.row - 1].inventoryName, inventoryFiltered[indexPath.row - 1].minimumInventory, isSelected: inventoryFiltered[indexPath.row - 1].isSelected)
            
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
                inventoryFiltered = InventoryEditInformation.inventoryEditArray
                categoryEditTableView.reloadData()
            }
        }
        if !allCategoryCheck {
            inventoryFiltered = []
            for i in 0..<selections.count {
                let filterred = InventoryEditInformation.inventoryEditArray.filter { (inventory) -> Bool in
                    return inventory.category == selections[i]
                }
                
                for data in filterred {
                    inventoryFiltered.append(data)
                }
            }
            categoryEditTableView.reloadData()
        }
    }
}
