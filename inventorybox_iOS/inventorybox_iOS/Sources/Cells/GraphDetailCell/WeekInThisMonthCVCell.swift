//
//  WeekInThisMonthCVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class WeekInThisMonthCVCell: UICollectionViewCell {
    
    
    @IBOutlet var weekBtn: UIButton!
    @IBOutlet var weekLabel: UILabel!
    
    //버튼을 클릭했을 때 몆주차에 해당하는 버튼인지 저장하는 변수
    var clickWeekInfo:String = ""
    var week: Int?
    var status: Bool = false {
        didSet {
            if status {
                self.weekBtn.backgroundColor = .yellow
                self.weekBtn.setTitleColor(.white, for: .normal)
                weekBtn.isSelected = true
            } else {
                self.weekBtn.backgroundColor = .white
                self.weekBtn.setTitleColor(.charcoal, for: .normal)
                weekBtn.isSelected = false
            }
        }
    }
    
    override func awakeFromNib() {
         print("awakeFromNib")
//        weekBtn.layer.cornerRadius = 12
//        weekBtn.backgroundColor = .yellow
    }
//
//    func setWeekInfo(monthOfWeek:String, isSelect:Bool){
//
//        print("setWeekInfo")
//        weekBtn.titleLabel?.text = monthOfWeek
//        weekLabel.text = monthOfWeek
//        weekBtn.layer.cornerRadius = 12
//        weekBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
//        weekBtn.layer.shadowOpacity = 0.1
//        weekBtn.layer.borderWidth = 0.1
//        status = isSelect
//        print("setWeekInfo\(isSelect)")
//        print("setWeekInfo\(status)")
//
//
//    }
    
    @IBAction func clickWeeks(_ sender: Any) {
        print(1111111)
        
        
        if self.weekBtn.isSelected {
                       print("clickWeeks",weekBtn.isSelected)
                       // set deselected
                       status = false
                       self.weekBtn.backgroundColor = .white
            self.weekBtn.setTitleColor(.charcoal, for: .normal)
                       weekBtn.isSelected = false
                   } else {
                       print("clickWeeks",weekBtn.isSelected)
                       // set selected
                       status = true
                       self.weekBtn.backgroundColor = .yellow
            self.weekBtn.setTitleColor(.white, for: .normal)
                       weekBtn.isSelected = true
                   }
               
       
       NotificationCenter.default.post(name: .clickWeek, object: nil, userInfo: ["week": week, "status": status])
        
          print("clickWeeks")
      
    }
           
    
    }

