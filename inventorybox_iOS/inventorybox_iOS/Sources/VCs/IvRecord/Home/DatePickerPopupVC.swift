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
    
    private func setButtonCustom() {
        completeBtn.layer.cornerRadius = 25
        completeBtn.backgroundColor = UIColor.yellow
        completeBtn.tintColor = UIColor.white
    }
    
    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko")
        datePicker.backgroundColor = UIColor.white
        // 초기 날짜 설정
        guard let date = dateMemorized else { return }
        datePicker.date = date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDatePicker()
        setButtonCustom()
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        NotificationCenter.default.post(name: .init("popup"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectDate(_ sender: Any) {
        let date = datePicker.date
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["selectedDate": date])
        self.dismiss(animated: true)
    }
    
}
