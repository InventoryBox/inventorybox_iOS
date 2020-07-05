//
//  IvRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/02.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvRecordVC: UIViewController {
    
    @IBOutlet weak var datePickerBtn: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categorySettingBtn: UIButton!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var inventoryTableView: UITableView!
    
    private let datePicker = UIDatePicker()
    
    // category 통신
    private let categoryArray: [String] = ["전체", "스파게티", "유제품", "파운드류", "원두", "이게정말길게짜는것"]
    private var inventoryArray: [InventoryInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createdDatePicker()
        setInventoryData()
        setTableView()
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        self.view.backgroundColor = UIColor.whiteThree
        
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
            headerCell.backgroundColor = UIColor.whiteThree
            return headerCell
        } else {
            guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCell.identifier, for: indexPath) as? InventoryCell else { return UITableViewCell() }
            
            inventoryCell.setInventoryData(inventoryArray[indexPath.row - 1].inventoryImageName, inventoryArray[indexPath.row - 1].inventoryName, inventoryArray[indexPath.row - 1].minimumInventory, inventoryArray[indexPath.row - 1].orderInventory, inventoryArray[indexPath.row - 1].inventoryCount)
            inventoryCell.backgroundColor = UIColor.whiteThree
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
