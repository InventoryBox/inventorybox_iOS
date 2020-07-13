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
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayDateLable: UILabel!
    @IBOutlet weak var inventoryTodayRecordTableView: UITableView!
    @IBOutlet weak var completeBtn: UIButton!
    
    var textFieldBox: [Int] = []
    
    var inventoryTodayArray: [InventoryTodayInformation] = {
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
    
    private var selections = [String]()
    
    private var inventoryFilteredArray: [InventoryTodayInformation] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInventoryFilteredData()
        addCategoryCollectionView()
        makeShadowUnderOutView()
        setInventoryTodayRecordTableView()
        customCompleteBtn()
        
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
        
//        self.view.frame.origin.y = -200 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
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
        
        self.dismiss(animated: true) {
            // 플로팅 버튼 없애는 코드???
        }
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
            
            
            inventoryTodayRecordCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].inventoryImageName, inventoryFilteredArray[indexPath.row - 1].inventoryName, inventoryFilteredArray[indexPath.row - 1].inventoryCount)
            
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
    func isTextFieldFilled(count: String,  isTyped: Bool, indexPath: Int) {
        
        if self.textFieldBox.contains(indexPath) {
            if !isTyped {
                print("empty")
                guard let i = self.textFieldBox.firstIndex(of: indexPath) else { return }
                inventoryTodayArray[indexPath].inventoryCount = count
                self.textFieldBox.remove(at: i)
                inventoryFilteredArray = inventoryTodayArray
                print(textFieldBox)
            }
        } else {
            if isTyped {
                print("filled")
                textFieldBox.append(indexPath)
                inventoryTodayArray[indexPath].inventoryCount = count
                print(textFieldBox)
                inventoryFilteredArray = inventoryTodayArray
            }
            
        }
        
        if inventoryTodayArray.count == textFieldBox.count {
            completeBtn.backgroundColor = UIColor.yellow
            completeBtn.tintColor = UIColor.white
            completeBtn.isEnabled = true
        } else {
            //            completeBtn.backgroundColor = UIColor.pinkishGrey
            //            completeBtn.tintColor = UIColor.white
            //            completeBtn.isEnabled = false
            completeBtn.backgroundColor = UIColor.yellow
            completeBtn.tintColor = UIColor.white
            completeBtn.isEnabled = true
        }
    }
}







//MARK: - TagCollectionView
extension IvTodayRecordVC: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        // 한개만 선택되게 만드는 코드
        // 카테고리 전체 어떻게 할것인가?
        
        
        // selection 배열 내에 한개씩만 선택되게 만들기
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
                inventoryFilteredArray = inventoryTodayArray
                inventoryTodayRecordTableView.reloadData()
            }
        }
        
        if !allCategoryCheck {
            inventoryFilteredArray = []
            for i in 0..<selections.count {
                let filterred = inventoryTodayArray.filter { (inventory) -> Bool in
                    return inventory.category == selections[i]
                }
                
                for data in filterred {
                    inventoryFilteredArray.append(data)
                }
            }
            inventoryTodayRecordTableView.reloadData()
        }
        
    }
}

