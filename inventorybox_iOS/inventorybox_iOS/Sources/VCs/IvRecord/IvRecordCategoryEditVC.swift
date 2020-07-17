//
//  IvRecordCategoryEditVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox

class IvRecordCategoryEditVC: UIViewController {
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var categoryEditTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet var bottomView: [UIView]!
    
    @IBOutlet weak var popupBackgroundView: UIView!
    
    
//    private var selections = [String]()
    private var checkboxSelections = [Int]()
    
    var dateToSend: String?
    
    var categories: [CategoryInfo] = [] {
        didSet {
            self.setCategoryCollectionView()
        }
    }
    
    var inventoryEditArray: [EditCateInfo] = [] {
        didSet {
            
        }
    }
    
    private var inventoryFilteredArray: [EditCateInfo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer(dateToSend!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setInventoryFilteredData()
        setShadowUnderOutView()
        setCategoryEditTableView()
        setViewCustom()
        setPopupBackgroundView()
        
    }
    private func setCategoryCollectionView() {
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
    }
    
    private func getDataFromServer(_ date: String) {
        
        IvRecordEditCateService.shared.getRecordEditCate(whichDate: date) { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? IvRecordEditCateClass else { return }
                
                
                // 데이터 정렬
                if let itemArray = dt.itemInfo {
                    self.inventoryEditArray = itemArray
                }
                
                self.categories = dt.categoryInfo
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
        
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
        
//        guard let info = notification.userInfo as? [String: Any] else { return }
//        guard let name = info["categoryName"] as? String else { return }
//
//
//
//        categoryEditTableView.reloadData()
//
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        animatePopupBackground(false)
//        guard let info = notification.userInfo as? [String: Any] else { return }
//        guard let name = info["categoryName"] as? String else { return }
//        print(name)
    
        setCategoryCollectionView()
    }
//    private func getCatecoryFromServer() {
//
//        CategoryService.shared.getCategory() { (networkResult) in
//            switch networkResult {
//            case .success(let data):
//                guard let dt = data as? CategoryClass else { return }
//                print(dt)
//
//                self.categories = dt.categoryInfo
////                self.categoryCollectionView.reloadData()
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
//
//    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func deleteInventoryBtnPressed(_ sender: Any) {
        // 선택된 재료 삭제하기 서버 반영 버튼
//        print(checkboxSelections)
        
        var idxList: [Int] = []
        for i in 0..<checkboxSelections.count {
            idxList.append(inventoryEditArray[i].itemIdx)
        }
        IvRecordDeleteIvService.shared.deleteIv(idxList: idxList) { (networkResult) in
            switch networkResult {
            case .success(let data):
                print(data)
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
        
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
            
            inventoryCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].img, inventoryFilteredArray[indexPath.row - 1].name, inventoryFilteredArray[indexPath.row - 1].alarmCnt)

            
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
//MARK: - CellButtonDelegate

extension IvRecordCategoryEditVC: CellButtonDelegate {
    func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: Int) {
        
        print("allTap")
        for i in 0..<inventoryFilteredArray.count {
            if isClicked {
                if self.checkboxSelections.contains(i) {
                    guard let index = self.checkboxSelections.firstIndex(of: i) else { return }
                    self.checkboxSelections.remove(at: index)
                    
                } else {
                    checkboxSelections.append(i)
                }

            } else {
                checkboxSelections = []
            }

        }
        categoryEditTableView.reloadData()
        
    }
//
    func didClickCheckButton(isClicked: Bool, indexPath: Int) {

        if self.checkboxSelections.contains(indexPath) {
            guard let i = self.checkboxSelections.firstIndex(of: indexPath) else { return }
            self.checkboxSelections.remove(at: i)
        } else {
            checkboxSelections.append(indexPath)
        }

        
    }
}

//MARK: - CollectionView

extension IvRecordCategoryEditVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        categoryCell.setTag(tagName: categories[indexPath.row].name)
        
        return categoryCell
    }
    
    
}

extension IvRecordCategoryEditVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 카테고리 필터링 코드
        var allCategoryCheck: Bool = false
        
        if categories[indexPath.row].name  == "전체" {
            allCategoryCheck = true
            inventoryFilteredArray = inventoryEditArray
            categoryEditTableView.reloadData()
        }
        
        
        if !allCategoryCheck {
            
            inventoryFilteredArray = []
            let filtered = inventoryEditArray.filter { (inventory) -> Bool in
                return inventory.categoryIdx == categories[indexPath.row].categoryIdx
            }
            
            for data in filtered {
                inventoryFilteredArray.append(data)
            }
            
            categoryEditTableView.reloadData()
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 24)
    }
}
