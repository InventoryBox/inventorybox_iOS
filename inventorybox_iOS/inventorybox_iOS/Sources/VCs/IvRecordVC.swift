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
    
    @IBOutlet weak var datePickerBtn: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categorySettingBtn: UIButton!
    @IBOutlet weak var goUpBtn: UIButton!
    @IBOutlet weak var oneLineView: UIView!
    
    @IBOutlet weak var inventoryTableView: UITableView!
    
    let categoryCollectionView = TTGTextTagCollectionView()
    private var selections = [String]()
    
    private let datePicker = UIDatePicker()
    
    private let categoryArray: [String] = ["전체", "스파게티", "유제품", "파운드류", "원두", "이게정말길게짜는것"]
    
    private var inventoryArray: [InventoryInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createdDatePicker()
        setInventoryData()
        setTableView()
        setBackgroundColor()
        setBtn()
        setCategoryCollectionView()
        setOneLine()
    }
    
    @IBAction func scroll(_ sender: Any) {
        // scrollToTop tableView code
        let indexPath = IndexPath(row: 0, section: 0)
        self.inventoryTableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
    private func setOneLine() {
        oneLineView.backgroundColor = UIColor.whiteThree
    }
    
    private func setCategoryCollectionView() {
        categoryCollectionView.alignment = .fillByExpandingWidth
        categoryCollectionView.delegate = self
        categoryCollectionView.numberOfLines = 1
        categoryCollectionView.scrollDirection = TTGTagCollectionScrollDirection.horizontal
        categoryCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(categoryCollectionView)
        
        let config = TTGTextTagConfig()
        config.backgroundColor = UIColor.white
        config.textColor = UIColor.black
        config.borderColor = UIColor.veryLightPink
        config.borderWidth = 1
        config.cornerRadius = 20
        config.enableGradientBackground = false
        config.shadowOpacity = 0
        config.shadowOffset = CGSize(width: 0, height: 0)
        config.exactHeight = 24
        config.selectedBackgroundColor = UIColor.greyishBrown
        config.selectedCornerRadius = 20
        config.textFont = UIFont(name: "Helvetica Neue", size: 11.0)
        categoryCollectionView.addTags(["전체", "액체류", "파우더류", "과일", "차류", "스파게티재료", "항상 체크해야 하는 리스트", "ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ","ㅁㅇㄴㄹㄴㅇㅁㄹㅁㄴㅇㄹㅁㄴㄹㅁㅇㄴ"], with: config)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: self.categorySettingBtn.leadingAnchor, constant: -22).isActive = true
        NSLayoutConstraint(item: categoryCollectionView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: categorySettingBtn,
                           attribute: .centerY,
                           multiplier: 1.0,
            constant: 0.0).isActive = true

    }
    
    private func setBtn() {
        goUpBtn.layer.cornerRadius = goUpBtn.frame.height / 2
        goUpBtn.layer.shadowOpacity = 0.25
        goUpBtn.layer.shadowRadius = 5
        goUpBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    private func setBackgroundColor() {
        //        self.view.layer.shadowOpacity = 22
        //        self.view.layer.shadowRadius = 5
//                self.view.backgroundColor = UIColor.whiteThree
    }
    
    private func setTableView() {
        inventoryTableView.delegate = self
        inventoryTableView.dataSource = self
        
        inventoryTableView.allowsSelection = false
        inventoryTableView.separatorStyle = .none
    }
    
    private func setInventoryData() {
        let data1 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data2 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data3 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data4 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data5 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data6 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data7 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data8 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data9 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        let data10 = InventoryInformation(imageName: "lastrecordingIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3")
        
        inventoryArray = [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10]
        
    }
    
    
    // datePickerBtn event
    private func createdDatePicker() {
        
        datePicker.datePickerMode = .date
        
        datePicker.locale = Locale(identifier: "ko")
        
        datePicker.timeZone = NSTimeZone.local
        
        datePickerBtn.inputView = datePicker
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        datePickerBtn.inputAccessoryView = toolbar
        
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


//MARK: - TableView

extension IvRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
            
            
            
            return headerCell
            
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCell.identifier, for: indexPath) as? InventoryCell else { return UITableViewCell() }
            
            inventoryCell.setInventoryData(inventoryArray[indexPath.row - 1].inventoryImageName, inventoryArray[indexPath.row - 1].inventoryName, inventoryArray[indexPath.row - 1].minimumInventory, inventoryArray[indexPath.row - 1].orderInventory, inventoryArray[indexPath.row - 1].inventoryCount)
            
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

extension IvRecordVC: TTGTextTagCollectionViewDelegate {
    
}
