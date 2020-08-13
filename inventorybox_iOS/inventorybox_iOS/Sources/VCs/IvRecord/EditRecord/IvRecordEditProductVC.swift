//
//  IvRecordEditProductVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvRecordEditProductVC: UIViewController {
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayDateLabel: UILabel!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var inventoryEditPrdoctTableView: UITableView!
    
    @IBOutlet weak var completeBtn: UIButton!
    
    
    var textFieldBox: [Int] = []
    
    var dateToSend: String?
    
    var memorizeDate: String?
    
    var categories: [CategoryInfo] = [] {
        didSet {
            self.setCategoryCollectionView()
        }
    }
    
    var inventoryEditProductArray: [EditItemInfo] = [] {
        didSet {
            
        }
    }
    
    private var selections = [String]()
    
    private var inventoryFilteredArray: [EditItemInfo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getDataFromServer(dateToSend!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: .init("update"), object: nil)
    }
    
    @objc private func update() {
        
            print("hi")
            getDataFromServer(dateToSend!)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInventoryFilteredData()
        customCompleteBtn()
        setinventoryEditPrdoctTableViewTableView()
        makeShadowUnderOutView()
        setDate()
        
        
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        let keyboardHeight = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.inventoryEditPrdoctTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.inventoryEditPrdoctTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setDate() {
        todayDateLabel.text = memorizeDate!
    }
    private func setInventoryFilteredData() {
        inventoryFilteredArray = inventoryEditProductArray
    }
    
    private func setCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
    }
    
    private func getDataFromServer(_ date: String) {
        
        IvRecordEditIvService.shared.getRecordEditIv(whichDate: date) { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? IvRecordEditIvClass else { return }
                
                if let itemInfo = dt.itemInfo {
                     self.inventoryEditProductArray = itemInfo
                     
                }
                if let itemArray = dt.itemInfo {
                    
                    self.inventoryEditProductArray = itemArray
                    
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
        
//        print(inventoryEditProductArray)
        // 서버 통신 코드
        IvRecordEditIvPostService.shared.getRecordEditIvPost(data: inventoryEditProductArray, date: dateToSend!, completion: { networkResult in
            switch networkResult {
            case .success(let data):
                print(data)

            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)

            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        })
        
        NotificationCenter.default.post(name: .init("update"), object: nil)
        self.dismiss(animated: false, completion: nil)
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
            
            
            inventoryTodayRecordCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].img, inventoryFilteredArray[indexPath.row - 1].name, inventoryFilteredArray[indexPath.row - 1].stocksCnt)
            
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
    func isTextFieldFilled(count: Int, isTyped: Bool, indexPath: Int) {
        inventoryEditProductArray[indexPath].stocksCnt = count
    }
    
    func isTextFieldFilled(count: String,  isTyped: Bool, indexPath: Int) {
        
        if let cnt = Int(count) {
            inventoryEditProductArray[indexPath].stocksCnt = cnt
        }
        
        inventoryFilteredArray = inventoryEditProductArray
        
        
    }
}

//MARK: - CollectionView

extension IvRecordEditProductVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        categoryCell.setTag(tagName: categories[indexPath.row].name)
        
        return categoryCell
    }
    
    
}

extension IvRecordEditProductVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 카테고리 필터링 코드
        var allCategoryCheck: Bool = false
        
        if categories[indexPath.row].name  == "전체" {
            allCategoryCheck = true
            inventoryFilteredArray = inventoryEditProductArray
            inventoryEditPrdoctTableView.reloadData()
        }
        
        
        if !allCategoryCheck {
            
            inventoryFilteredArray = []
            let filtered = inventoryEditProductArray.filter { (inventory) -> Bool in
                return inventory.categoryIdx == categories[indexPath.row].categoryIdx
            }
            
            for data in filtered {
                inventoryFilteredArray.append(data)
            }
            
            inventoryEditPrdoctTableView.reloadData()
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 24)
    }
}