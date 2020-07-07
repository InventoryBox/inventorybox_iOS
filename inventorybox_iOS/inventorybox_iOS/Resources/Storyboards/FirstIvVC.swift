//
//  NoIvVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class FirstIvVC: UIViewController {
    
    let categoryCollectionView = TTGTextTagCollectionView()
    private var selections = [String]()
    private let datePicker = UIDatePicker()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var datePickerBtn: CustomTextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePickerLabelBtn: CustomTextField!
    @IBOutlet weak var registerInventoryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCategoryCollectionView()
        createdDatePicker()
        setregisterInventoryBtn()
        makeShadowUnderOutView()
        
    }
    
    private func makeShadowUnderOutView() {
        
        self.outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.outView.layer.shadowOpacity = 0.05
        self.outView.layer.shadowRadius = 2
        
    }
    
    private func setregisterInventoryBtn() {
        
        registerInventoryBtn.backgroundColor = UIColor.yellow
        registerInventoryBtn.tintColor = UIColor.white
        registerInventoryBtn.layer.cornerRadius = 18
        
    }
    
    private func addCategoryCollectionView() {
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.setCategoryCollectionView()
        
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        categoryCollectionView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 8).isActive = true
        
        categoryCollectionView.addTags(["전체"], with: categoryCollectionView.setCategoryConfig())
        
    }
    // datePickerBtn event
    private func createdDatePicker() {
        
        datePicker.datePickerMode = .date
        
        datePicker.locale = Locale(identifier: "ko")
        
        datePicker.timeZone = NSTimeZone.local
        
        datePickerBtn.inputView = datePicker
        datePickerLabelBtn.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
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

extension FirstIvVC: TTGTextTagCollectionViewDelegate {
    
}
