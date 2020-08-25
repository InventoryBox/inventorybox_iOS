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
    
    var textFieldBoxSelections: [Int] = []
    var dateToSend: String?
    var inventoryTodayArray: [TodayItemInfo] = []
    private var inventoryFilteredArray: [TodayItemInfo] = []
    var categories: [CategoryInfo] = [] {
        didSet {
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
            collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
            print(inventoryTodayArray)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromServer()
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        // 키보드 올리는 함수
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let keyboardHeight = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.inventoryTodayRecordTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.inventoryTodayRecordTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeShadowUnderOutView()
        setInventoryTodayRecordTableView()
        customCompleteBtn()
        
    }
    
    private func filteredArraySelections(with array: [TodayItemInfo] = []) {
        inventoryFilteredArray = array
        for i in 0..<inventoryFilteredArray.count {
            if inventoryFilteredArray[i].presentCnt != -1 {
                textFieldBoxSelections.append(i)
            }
        }
        inventoryTodayRecordTableView.reloadData()
    }
    
    private func makeShadowUnderOutView() {
        self.outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.outView.layer.shadowOpacity = 0.05
        self.outView.layer.shadowRadius = 2
    }
    
    private func setInventoryTodayRecordTableView() {
        
        inventoryTodayRecordTableView.delegate = self
        inventoryTodayRecordTableView.dataSource = self
        
        inventoryTodayRecordTableView.allowsSelection = false
        inventoryTodayRecordTableView.separatorStyle = .none
        
    }
    
    private func customCompleteBtn() {
        
        completeBtn.layer.cornerRadius = 25
        completeBtn.backgroundColor = UIColor.yellow
        completeBtn.tintColor = UIColor.white
        completeBtn.isEnabled = true
        
    }
    
    private func getDataFromServer() {
        
        IvRecordTodayService.shared.getRecordTodayIv() { (networkResult) in
            switch networkResult {
            case .success(let data):
                guard let dt = data as? IvRecordTodayIvClass else { return }
                self.dateToSend = dt.date.components(separatedBy: " ")[0].toDate().toString()
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
    
    @IBAction func goToAddProductVC(_ sender: Any) {
        let IvRecordAddProductST = UIStoryboard.init(name: "IvRecordAddProduct", bundle: nil)
        guard let addProductVC = IvRecordAddProductST.instantiateViewController(identifier: "IvRecordNaviVC")
            as? IvRecordNaviVC else { return }
        addProductVC.modalPresentationStyle = .fullScreen
        self.present(addProductVC, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTodayDatas(_ sender: Any) {
        // 오늘 재고 기록 post 서버 통신
        IvRecordTodayPostService.shared.getRecordTodayIvPost(data: inventoryTodayArray, date: dateToSend!, completion: { networkResult in
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
        
        let seconds = 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            NotificationCenter.default.post(name: .init("sendDataFromTodayRecordToHome"), object: nil)
            self.dismiss(animated: true)
        }
        
    }
}

//MARK: - inventoryTodayRecordTableView
extension IvTodayRecordVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryFilteredArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: AddIvHeaderCell.identifier, for: indexPath) as? AddIvHeaderCell else { return UITableViewCell() }
            return headerCell
        } else {
            guard let inventoryTodayRecordCell = tableView.dequeueReusableCell(withIdentifier: InventoryTodayRecordCell.identifier, for: indexPath) as? InventoryTodayRecordCell else { return UITableViewCell() }
            inventoryTodayRecordCell.delegate = self
            inventoryTodayRecordCell.indexPath = indexPath.row - 1 // headerCell 인덱스값 빼줍니다
            inventoryTodayRecordCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].img, inventoryFilteredArray[indexPath.row - 1].name)
            if textFieldBoxSelections.contains(indexPath.row - 1) {
                inventoryTodayRecordCell.ivCnt = inventoryFilteredArray[indexPath.row - 1].presentCnt
                inventoryTodayRecordCell.isTyped = true
            }
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
    func isTextFieldFilled(count: Int, indexPath: Int) {
        // 오늘의 기록을 입력하지 않은 재고는 -1 로 저장해준다.
        // 또한 입력을 하지 않았으므로 boxSelections에서 제외시켜준다.
        inventoryFilteredArray[indexPath].presentCnt = count
        for i in 0..<inventoryTodayArray.count {
            if inventoryFilteredArray[indexPath].itemIdx == inventoryTodayArray[i].itemIdx {
                inventoryTodayArray[i].presentCnt = inventoryFilteredArray[indexPath].presentCnt
                break
            }
        }
        if (count > 0) {
            if !textFieldBoxSelections.contains(indexPath) {
                textFieldBoxSelections.append(indexPath)
            }
        } else {
            if textFieldBoxSelections.contains(indexPath) {
                guard let i = textFieldBoxSelections.firstIndex(of: indexPath) else { return }
                textFieldBoxSelections.remove(at: i)
            }
        }
    }
}


//MARK: - CategoryCollectionView
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
            filteredArraySelections(with: inventoryTodayArray)
        }
        if !allCategoryCheck {
            inventoryFilteredArray = []
            let filtered = inventoryTodayArray.filter { (inventory) -> Bool in
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
