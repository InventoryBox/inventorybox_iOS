//
//  IvRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/02.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class IvRecordVC: UIViewController {
    
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var datePickerBtn: UIButton!
    @IBOutlet weak var datePickerLabelBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var categorySettingBtn: UIButton!
    @IBOutlet weak var floatingUpBtn: UIButton!
    @IBOutlet weak var floatingTodayRecordBtn: UIButton!
    
    @IBOutlet weak var firstRegisterView: UIView!
    @IBOutlet weak var firstRegisterBtn: UIButton!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var inventoryTableView: UITableView!
    
    @IBOutlet weak var popupBackgroundView: UIView!
    let categoryCollectionView = TTGTextTagCollectionView()
    
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
     
    let inventoryArray: [InventoryInformation] = {
        
        let data1 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5", unit: "팩", iCount: "99", categoryNum: "액체류")
        let data2 = InventoryInformation(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10", unit: "팩", iCount: "3", categoryNum: "액체류")
        let data3 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",  iCount: "3", categoryNum: "과일")
        let data4 = InventoryInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "통", iCount: "3", categoryNum: "파우더류")
        let data5 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        let data6 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        let data7 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유",  mInventory: "10", unit: "팩", iCount: "99", categoryNum: "액체류")
        let data8 = InventoryInformation(imageName: "homeIcMilk", ivName: "녹차 파우더",  mInventory: "10", unit: "팩", iCount: "3", categoryNum: "파우더류")
        let data9 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩", iCount: "3", categoryNum: "과일")
        let data10 = InventoryInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "팩", iCount: "3", categoryNum: "액체류")
        let data11 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        let data12 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
        
    }()

    private var selections = [String]()
    
    private var inventoryFilteredArray: [InventoryInformation] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInventoryFilteredData()
        isTodayRecordDone()
        whichViewWillShow()
        setBtnsCustommed()
        setInventoryTableView()
        setBackgroundColor()
        addCategoryCollectionView()
        makeShadowUnderOutView()
        setPopupBackgroundView()
        
    }
    
    private func setInventoryFilteredData() {
        inventoryFilteredArray = inventoryArray
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
        
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let date = info["selectdDate"] as? String else { return }
        print(date)
        dateLabel.text = date
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func openDatePicker(_ sender: Any) {
        animatePopupBackground(true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DatePickerPopupVC") else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    @IBAction func goToIvRecordAddProduct(_ sender: Any) {
        let IvRecordAddProductST = UIStoryboard.init(name: "IvRecordAddProduct", bundle: nil)
        guard let addProductVC = IvRecordAddProductST.instantiateViewController(identifier: "IvRecordAddProductVC")
            as? IvRecordAddProductVC  else {
                return
        }
        addProductVC.modalPresentationStyle = .fullScreen
        
        self.present(addProductVC, animated: true, completion: nil)
    }
    
    @IBAction func goToIvRecordEditProduct(_ sender: Any) {
        let IvRecordEditProductST = UIStoryboard.init(name: "IvRecordEditProduct", bundle: nil)
        guard let editProductVC = IvRecordEditProductST.instantiateViewController(identifier: "IvRecordEditProductVC")
            as? IvRecordEditProductVC  else {
                return
        }
        editProductVC.modalPresentationStyle = .fullScreen
        
        self.present(editProductVC, animated: false, completion: nil)
    }
    @IBAction func goToIvRecordCategoryEdit(_ sender: Any) {
        
        let IvRecordCategoryEditST = UIStoryboard.init(name: "IvRecordCategoryEdit", bundle: nil)
        guard let categoryEditVC = IvRecordCategoryEditST.instantiateViewController(identifier: "IvRecordCategoryEditVC")
            as? IvRecordCategoryEditVC  else {
                return
        }
        categoryEditVC.modalPresentationStyle = .fullScreen
        
        self.present(categoryEditVC, animated: false, completion: nil)
        
    }
    
    @IBAction func goToIvTodayRecord(_ sender: Any) {
        
        let IvTodayRecord = UIStoryboard.init(name: "IvTodayRecord", bundle: nil)
        guard let IvTodayRecordVC = IvTodayRecord.instantiateViewController(identifier: "IvTodayRecordVC")
            as? IvTodayRecordVC  else {
                return
        }
        IvTodayRecordVC.modalPresentationStyle = .fullScreen
        
        self.present(IvTodayRecordVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func scrollUpBtnPressed(_ sender: Any) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.inventoryTableView.scrollToRow(at: indexPath, at: .top, animated: false)
        
    }
    
    private func isTodayRecordDone() {
        // 오늘 기록을 했다면
        floatingUpBtn.isHidden = true
        
        // 오늘 기록을 하지 않았다면
        floatingUpBtn.isHidden = false
    }
    
    private func whichViewWillShow() {
        
        // 빈 data가 온다면 재료 등록하기 뷰사용
        //firstRegisterView.isHidden = false
        //noDataView.isHidden = true
        //inventoryTableView.isHidden = true
        
        // 데이터피커를 통해 날짜를 보냈는데 빈 data가 온다면 재료가 없습니다 뷰 사용
        //        firstRegisterView.isHidden = true
        //        noDataView.isHidden = false
        //        inventoryTableView.isHidden = true
        
        // 데이터가 들어온다면 테이블 뷰 사용
        firstRegisterView.isHidden = true
        noDataView.isHidden = true
        inventoryTableView.isHidden = false
    }
    
    private func setBtnsCustommed() {
        
        floatingTodayRecordBtn.layer.cornerRadius = 18
        floatingTodayRecordBtn.backgroundColor = UIColor.yellow
        floatingTodayRecordBtn.tintColor = UIColor.white
        
        firstRegisterBtn.layer.cornerRadius = 18
        firstRegisterBtn.backgroundColor = UIColor.yellow
        firstRegisterBtn.tintColor = UIColor.white
        
        
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
//        categoryCollectionView.
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        categoryCollectionView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 8).isActive = true
        
        categoryCollectionView.addTags(categories, with: categoryCollectionView.setCategoryConfig())
        
    }
    
    private func setBackgroundColor() {
        
    }
    
    private func setInventoryTableView() {
        
        inventoryTableView.delegate = self
        inventoryTableView.dataSource = self
        
        inventoryTableView.allowsSelection = false
        inventoryTableView.separatorStyle = .none
        
    }
    
    
    
}

//MARK: - CollectionView


//MARK: - InventoryTableView
extension IvRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryFilteredArray.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCell.identifier, for: indexPath) as? InventoryCell else { return UITableViewCell() }
            
            inventoryCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].inventoryImageName, inventoryFilteredArray[indexPath.row - 1].inventoryName, inventoryFilteredArray[indexPath.row - 1].minimumInventory, inventoryFilteredArray[indexPath.row - 1].inventoryUnit, inventoryFilteredArray[indexPath.row - 1].inventoryCount)
            
            return inventoryCell
            
        }
        
    }
    
    
}

extension IvRecordVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 35
            
        } else {
            
            return 102
            
        }
        
    }
}


//MARK: - TagCollectionView
extension IvRecordVC: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        // 한개만 선택되게 만드는 코드
//        if selections.count == 0 {
//            selections.append(tagText)
//        } else {
//            if selections[0] == "전체" {
//
//            }
//
//        }
        
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
                inventoryFilteredArray = inventoryArray
                inventoryTableView.reloadData()
            }
        }
        
        if !allCategoryCheck {
            inventoryFilteredArray = []
            for i in 0..<selections.count {
                let filterred = inventoryArray.filter { (inventory) -> Bool in
                    return inventory.category == selections[i]
                }
                
                for data in filterred {
                    inventoryFilteredArray.append(data)
                }
            }
            inventoryTableView.reloadData()
        }
        
    }
}
