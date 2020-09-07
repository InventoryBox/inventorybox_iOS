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
    @IBOutlet weak var categoryEditTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet var bottomView: [UIView]!
    
    @IBOutlet weak var popupBackgroundView: UIView!
    
    private var checkboxSelections = [Int]()
    var dateToSend: String?
    var allSelectedBtnPresseed: Bool = false
    var inventoryEditArray: [EditCateInfo] = []
    private var inventoryFilteredArray: [EditCateInfo] = []
    var categories: [CategoryInfo] = [] {
        didSet {
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
            collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
            filteredArraySelections(with: inventoryEditArray)
        }
    }
    
    private func filteredArraySelections(with array: [EditCateInfo] = []) {
        inventoryFilteredArray = array
        checkboxSelections = []
        for i in 0..<inventoryFilteredArray.count {
            if inventoryFilteredArray[i].isSelected {
                checkboxSelections.append(i)
            }
        }
        allSelectedBtnPresseed = checkboxSelections.count == inventoryFilteredArray.count ? true : false
        categoryEditTableView.reloadData()
        categoryEditTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .init("popupFromMoveCateToEditCate"), object: nil)
        NotificationCenter.default.removeObserver(self, name: .init("popupFromAddCateToEditCate"), object: nil)
        NotificationCenter.default.removeObserver(self, name: .init("popupFromDeleteCateToEditCate"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in bottomView {
            view.backgroundColor = UIColor.yellow
        }
        categoryEditTableView.delegate = self
        categoryEditTableView.dataSource = self
        categoryEditTableView.allowsSelection = false
        categoryEditTableView.separatorStyle = .none
        self.outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.outView.layer.shadowOpacity = 0.05
        setPopupBackgroundView()
        setNotificationCenter()
        if let date = dateToSend {
            getDataFromServer(date)
        }
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(popupFromMoveCateToEditCate), name: .init("popupFromMoveCateToEditCate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popupFromAddCateToEditCate), name: .init("popupFromAddCateToEditCate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popupFromDeleteCateToEditCate), name: .init("popupFromDeleteCateToEditCate"), object: nil)
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
    
    private func setPopupBackgroundView() {
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
    }
    
    func animatePopupBackground(_ direction: Bool) {
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
    }
    
    @IBAction func deleteInventoryBtnPressed(_ sender: Any) {
        // 선택된 재료 삭제하기 서버 반영 버튼
        var idxList: [Int] = []
        for i in 0..<inventoryEditArray.count {
            if inventoryEditArray[i].isSelected {
                idxList.append(inventoryEditArray[i].itemIdx)
            }
        }
        if idxList.isEmpty {
            let alertViewController = UIAlertController(title: "재료삭제 실패", message: "삭제할 재료를 선택해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        } else {
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
            
            let alertViewController = UIAlertController(title: "재료삭제 성공", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
            // 바로 반영
            var tempArray: [EditCateInfo] = inventoryEditArray
            for i in 0..<inventoryEditArray.count {
                if inventoryEditArray[i].isSelected {
                    guard let index = tempArray.firstIndex(where: { (item) -> Bool in return inventoryEditArray[i].itemIdx == item.itemIdx }) else { return }
                    tempArray.remove(at: index)
                }
            }
            inventoryEditArray = tempArray
            categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
            collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
            filteredArraySelections(with: inventoryEditArray)
        }
        
    }
    
    @IBAction func addCategoryBtnPressed(_ sender: Any) {
        animatePopupBackground(true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddCategoryPopupVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @objc func popupFromAddCateToEditCate(_ notification: Notification) {
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let name = info["categoryName"] as? String else { return }
        if name != "none" {
            let idx: Int = -1
            categories.append(CategoryInfo(categoryIdx: idx, name: name))
            categoryCollectionView.reloadData()
        }
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        filteredArraySelections(with: inventoryEditArray)
    }
    
    @IBAction func moveCategoryBtnPressed(_ sender: Any) {
        
        var idxList: [Int] = []
        for i in 0..<inventoryEditArray.count {
            if inventoryEditArray[i].isSelected {
                idxList.append(inventoryEditArray[i].itemIdx)
            }
        }
        if idxList.isEmpty {
            let alertViewController = UIAlertController(title: "폴더이동 실패", message: "이동할 재료를 선택해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        } else {
            animatePopupBackground(true)
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MoveCategoryPopupVC") else { return }
            vc.modalPresentationStyle = .overCurrentContext
            
            self.present(vc, animated: true)
        }
    }
    
    @objc func popupFromMoveCateToEditCate(_ notification: Notification) {
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let moveCategoryIdx = info["moveCategoryIdx"] as? Int else { return }
        var selected: [Int] = []
        for i in 0..<inventoryEditArray.count {
            if inventoryEditArray[i].isSelected {
                selected.append(inventoryEditArray[i].itemIdx)
                inventoryEditArray[i].categoryIdx = moveCategoryIdx
                inventoryEditArray[i].isSelected = false
            }
        }
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        filteredArraySelections(with: inventoryEditArray)
        
        IvRecordMoveCateService.shared.getRecordEditIvPost(selectedIdx: selected, categoryIdx: moveCategoryIdx) { (networkResult) in
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
    
    @IBAction func deleteCategoryBtnPressed(_ sender: Any) {
        animatePopupBackground(true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DeleteCategoryPopVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @objc func popupFromDeleteCateToEditCate(_ notification: Notification) {
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let categoryToDelete = info["categoryToDelete"] as? [Int] else { return }
        
        for i in 0..<categoryToDelete.count {
            let index = categories.firstIndex(where: { (category) -> Bool in
                return categoryToDelete[i] == category.categoryIdx
            })
            if let i = index {
                categories.remove(at: i)
            }
        }
        categoryCollectionView.reloadData()
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        filteredArraySelections(with: inventoryEditArray)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .init("sendDataFromEditCateToHome"), object: nil)
        self.dismiss(animated: false, completion: nil)
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
            headerCell.isClicked = allSelectedBtnPresseed
            return headerCell
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCategoryEditCell.identifier, for: indexPath) as? InventoryCategoryEditCell else { return UITableViewCell() }
            inventoryCell.delegate = self
            inventoryCell.indexPath = indexPath.row - 1
            inventoryCell.isSelectBtn = self.checkboxSelections.contains(indexPath.row - 1)
            inventoryCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].img, inventoryFilteredArray[indexPath.row - 1].name, inventoryFilteredArray[indexPath.row - 1].unit, inventoryFilteredArray[indexPath.row - 1].alarmCnt)
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
    func didAllBtnClickedCheckButton(isClicked: Bool) {
        if isClicked {
            for i in 0..<inventoryFilteredArray.count {
                inventoryFilteredArray[i].isSelected = true
                for j in 0..<inventoryEditArray.count {
                    if inventoryEditArray[j].itemIdx == inventoryFilteredArray[i].itemIdx {
                        inventoryEditArray[j].isSelected = inventoryFilteredArray[i].isSelected
                    }
                }
                if !checkboxSelections.contains(i) {
                    checkboxSelections.append(i)
                }
            }
        } else {
            for i in 0..<inventoryFilteredArray.count {
                inventoryFilteredArray[i].isSelected = false
                for j in 0..<inventoryEditArray.count {
                    if inventoryEditArray[j].itemIdx == inventoryFilteredArray[i].itemIdx {
                        inventoryEditArray[j].isSelected = inventoryFilteredArray[i].isSelected
                    }
                }
                checkboxSelections = []
            }
        }
        allSelectedBtnPresseed = checkboxSelections.count == inventoryFilteredArray.count ? true : false
        categoryEditTableView.reloadData()
    }
    
    func didClickCheckButton(isClicked: Bool, indexPath: Int) {
        inventoryFilteredArray[indexPath].isSelected = isClicked
        for i in 0..<inventoryEditArray.count {
            if inventoryEditArray[i].itemIdx == inventoryFilteredArray[indexPath].itemIdx {
                inventoryEditArray[i].isSelected = inventoryFilteredArray[indexPath].isSelected
            }
        }
        if checkboxSelections.contains(indexPath) {
            guard let i = checkboxSelections.firstIndex(of: indexPath) else { return }
            self.checkboxSelections.remove(at: i)
        } else {
            checkboxSelections.append(indexPath)
        }
        // 하나씩 전부 체크하고 전체선택을 눌렀을 때 문제 발생함
        allSelectedBtnPresseed = checkboxSelections.count == inventoryFilteredArray.count ? true : false
        categoryEditTableView.reloadData()
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
            filteredArraySelections(with: inventoryEditArray)
        }
        if !allCategoryCheck {
            inventoryFilteredArray = []
            let filtered = inventoryEditArray.filter { (inventory) -> Bool in
                return inventory.categoryIdx == categories[indexPath.row].categoryIdx
            }
            filteredArraySelections(with: filtered)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 24)
    }
}
