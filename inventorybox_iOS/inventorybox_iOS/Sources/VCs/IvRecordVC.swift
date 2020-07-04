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
    
    private let datePicker = UIDatePicker()
    
    let categoryArray: [String] = ["전체", "스파게티", "유제품", "파운드류", "원두", "이게정말길게짜는것"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createdDatePicker()
        //        categoryCollectionView.delegate = self
        //        categoryCollectionView.dataSource = self
        
    }
    
    private func createdDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko")
        datePicker.timeZone = NSTimeZone.local
        datePickerBtn.inputView = datePicker
        
        // toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        // donebtn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        datePickerBtn.inputAccessoryView = toolbar
        
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd eeee"
        formatter.locale = Locale(identifier: "ko")
        dateLabel.text = "\(formatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
}

//MARK: - CollectionView
extension IvRecordVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        categoryCell.setCategories(categoryArray[indexPath.row])
        
        return categoryCell
    }
    
}

extension IvRecordVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return CGSize() }
        
        return CGSize(width: categoryCell.categoryBtn.frame.width, height: categoryCell.categoryBtn.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
