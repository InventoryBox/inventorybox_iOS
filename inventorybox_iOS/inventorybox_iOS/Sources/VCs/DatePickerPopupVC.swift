//
//  DataPickerPopupVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class DatePickerPopupVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var completeBtn: UIButton!
    
    var dateMemorized: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDatePicker()
        setButtonCustom()
    }
    
    private func setButtonCustom() {
        completeBtn.layer.cornerRadius = 25
        completeBtn.backgroundColor = UIColor.yellow
        completeBtn.tintColor = UIColor.white
    }
    
    private func setDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko")
        datePicker.backgroundColor = UIColor.white
        
    }
    
    @IBAction func selectDate(_ sender: Any) {
        let date = datePicker.date
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd eeee"
        
        formatter.locale = Locale(identifier: "ko")
        dateMemorized = date
        
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["selectdDate": formatter.string(from: date)])
        self.dismiss(animated: true)
    }
}
