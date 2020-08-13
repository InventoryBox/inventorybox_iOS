//
//  IvTodayRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvTodayRecordVC: UIViewController {
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var inventoryTodayRecordTableView: UITableView!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var textFieldBox: [Int] = []
    
    var categories: [CategoryInfo] = [] {
        didSet {
            self.setCategoryCollectionView()
        }
    }
    
    var inventoryTodayArray: [TodayItemInfo] = [] {
        didSet {
            
        }
    }
    private var selections = [String]()
    
    
    private var inventoryFilteredArray: [TodayItemInfo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: .init("update"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInventoryFilteredData()

        makeShadowUnderOutView()
        setInventoryTodayRecordTableView()
        customCompleteBtn()
        
        
    }
    @objc private func update() {
        getDataFromServer()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func getDataFromServer() {
           
           IvRecordTodayService.shared.getRecordTodayIv() { (networkResult) in
               switch networkResult {
               case .success(let data):
                   guard let dt = data as? IvRecordTodayIvClass else { return }
                   
                   
                   self.inventoryTodayArray = dt.itemInfo
                   self.todayDateLabel.text = dt.date
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
       
    private func setCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        let keyboardHeight = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.inventoryTodayRecordTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.inventoryTodayRecordTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setInventoryFilteredData() {
        inventoryFilteredArray = inventoryTodayArray
    }
    
    private func customCompleteBtn() {
        
        completeBtn.layer.cornerRadius = 25
        //        completeBtn.backgroundColor = UIColor.pinkishGrey
        //        completeBtn.tintColor = UIColor.white
        //        completeBtn.isEnabled = false
        completeBtn.backgroundColor = UIColor.yellow
        completeBtn.tintColor = UIColor.white
        completeBtn.isEnabled = true
        
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
    
    @IBAction func goToAddProductVC(_ sender: Any) {
        let IvRecordAddProductST = UIStoryboard.init(name: "IvRecordAddProduct", bundle: nil)
        guard let addProductVC = IvRecordAddProductST.instantiateViewController(identifier: "IvRecordNaviVC")
            as? IvRecordNaviVC  else {
                return
        }
        addProductVC.modalPresentationStyle = .fullScreen
        
        self.present(addProductVC, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveTodayDatas(_ sender: Any) {
        
        // 오늘 재고 기록 post 서버 통신
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "ko") as TimeZone?
//        dateFormatter.date
//        IvRecordTodayPostService.shared.getRecordTodayIvPost(data: inventoryTodayArray, date: , completion: <#T##(NetworkResult<Any>) -> Void#>)
        NotificationCenter.default.post(name: .init("update"), object: nil)
        self.dismiss(animated: true)
    }
}

//MARK: - InventoryEditTableView
extension IvTodayRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryFilteredArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            
            guard let inventoryTodayRecordCell = tableView.dequeueReusableCell(withIdentifier: InventoryTodayRecordCell.identifier, for: indexPath) as? InventoryTodayRecordCell else { return UITableViewCell() }
            
            inventoryTodayRecordCell.indexPath = indexPath.row - 1
            inventoryTodayRecordCell.delegate = self
            
            
            if indexPath.row == 1 {
                inventoryTodayRecordCell.makePlaceholder()
            }
            print(inventoryFilteredArray[indexPath.row - 1].presentCnt)
            inventoryTodayRecordCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].img, inventoryFilteredArray[indexPath.row - 1].name, inventoryFilteredArray[indexPath.row - 1].presentCnt)
            
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
    func isTextFieldFilled(count: Int, isTyped: Bool, indexPath: Int) {
        print(indexPath)
        print(count)
        inventoryTodayArray[indexPath].presentCnt = count
        inventoryFilteredArray = inventoryTodayArray
        
    }
    
}


//MARK: - CollectionView

extension IvTodayRecordVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        categoryCell.setTag(tagName: categories[indexPath.row].name)
        
        return categoryCell
    }
    
    
}

extension IvTodayRecordVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 카테고리 필터링 코드
        var allCategoryCheck: Bool = false
        
        if categories[indexPath.row].name  == "전체" {
            allCategoryCheck = true
            inventoryFilteredArray = inventoryTodayArray
            inventoryTodayRecordTableView.reloadData()
        }
        
        
        if !allCategoryCheck {
            
            inventoryFilteredArray = []
            let filtered = inventoryTodayArray.filter { (inventory) -> Bool in
                return inventory.categoryIdx == categories[indexPath.row].categoryIdx
            }
            
            for data in filtered {
                inventoryFilteredArray.append(data)
            }
            
            inventoryTodayRecordTableView.reloadData()
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 24)
    }
}


////MARK: - CellButtonDelegate
//extension IvTodayRecordVC: CellButtonDelegate {
//    func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: Int) {
//
//    }
//
//    func didClickCheckButton(isClicked: Bool, indexPath: Int) {
//
//        if self.selections.contains(indexPath) {
//            guard let i = self.checkboxSelections.firstIndex(of: indexPath) else { return }
//            self.checkboxSelections.remove(at: i)
//        } else {
//            checkboxSelections.append(indexPath)
//        }
//
//
//    }
//}
