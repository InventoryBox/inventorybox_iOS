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
    
    static var categories: [String] = ["전체", "액체류", "파우더류", "과일", "채소류", "스파게티 재료들", "아침마다 확인해야 할 것들"]
    
    static var inventoryArray: [InventoryInformation] = {
        
        let data1 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data2 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data3 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data4 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data5 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data6 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        
        return [data1, data2, data3, data4, data5]
        
    }()
    
    private var inventoryFiltered: [InventoryInformation] = inventoryArray
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var datePickerBtn: UITextField!
    @IBOutlet weak var datePickerLabelBtn: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categorySettingBtn: UIButton!
    @IBOutlet weak var floatingUpBtn: UIButton!
    @IBOutlet weak var floatingTodayRecordBtn: UIButton!
    
    @IBOutlet weak var inventoryTableView: UITableView!
    
    let categoryCollectionView = TTGTextTagCollectionView()
    
    private var selections = [String]()
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnsCustommed()
        createdDatePicker()
        setInventoryTableView()
        setBackgroundColor()
        addCategoryCollectionView()
        makeShadowUnderOutView()
        
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
    
    private func setBtnsCustommed() {
        floatingTodayRecordBtn.layer.cornerRadius = 18
        floatingTodayRecordBtn.backgroundColor = UIColor.yellow
        floatingTodayRecordBtn.tintColor = UIColor.white
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
        
        categoryCollectionView.addTags(IvRecordVC.categories, with: categoryCollectionView.setCategoryConfig())
        
    }
    
    private func setBackgroundColor() {
        
    }
    
    private func setInventoryTableView() {
        inventoryTableView.delegate = self
        inventoryTableView.dataSource = self
        
        inventoryTableView.allowsSelection = false
        inventoryTableView.separatorStyle = .none
    }
    
    
    
    // datePickerBtn event
    private func createdDatePicker() {
        
        datePicker.datePickerMode = .date
        
        datePicker.locale = Locale(identifier: "ko")
        
        datePicker.timeZone = NSTimeZone.local
        
        datePickerBtn.inputView = datePicker
        datePickerLabelBtn.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 53))
        toolbar.backgroundColor = .yellow
        toolbar.isTranslucent = true
        toolbar.barTintColor = .yellow
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        datePickerBtn.inputAccessoryView = toolbar
        datePickerLabelBtn.inputAccessoryView = toolbar
    }
    
    // doneBtn event
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd eeee"
        
        formatter.locale = Locale(identifier: "ko")
        
        dateLabel.text = "\(formatter.string(from: datePicker.date))"
        
        self.view.endEditing(true)
        
    }
    
}

//MARK: - CollectionView


//MARK: - InventoryTableView
extension IvRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryFiltered.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            return headerCell
            
        } else {
            
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCell.identifier, for: indexPath) as? InventoryCell else { return UITableViewCell() }
            
            inventoryCell.setInventoryData(inventoryFiltered[indexPath.row - 1].inventoryImageName, inventoryFiltered[indexPath.row - 1].inventoryName, inventoryFiltered[indexPath.row - 1].minimumInventory, inventoryFiltered[indexPath.row - 1].orderInventory, inventoryFiltered[indexPath.row - 1].inventoryCount)
            
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
                inventoryFiltered = IvRecordVC.inventoryArray
                inventoryTableView.reloadData()
            }
        }
        if !allCategoryCheck {
            inventoryFiltered = []
            for i in 0..<selections.count {
                let filterred = IvRecordVC.inventoryArray.filter { (inventory) -> Bool in
                    return inventory.category == selections[i]
                }
                
                for data in filterred {
                    inventoryFiltered.append(data)
                }
            }
            inventoryTableView.reloadData()
        }
    }
}
