//
//  CalendarCVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class CalendarCVCell: UICollectionViewCell {
    
    @IBOutlet var selectImg: UIImageView!
    @IBOutlet var dayOfWeekLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    var thisWeek:[String] = []
    var day:[String] = ["일","월","화","수","목","금","토"]
    let date = Date()
    
    
    func setDayInformation(dayOfWeek:String,day:String,isToday:Bool){
        
        dayOfWeekLabel.text = dayOfWeek
        dayLabel.text = day
        
        if (isToday == true){
            selectImg.image = UIImage(named: "dataShapeDateYellow")
            print("dataShapeDateYellow")
            dayOfWeekLabel.textColor = .white
            dayLabel.textColor = .white
        }
        else{
            selectImg.image = UIImage(named: "dataShapeDateWhite")
            print("dataShapeDateWhite")
            dayOfWeekLabel.textColor = .noname
            dayLabel.textColor = .charcoal
        }
    }
    
    
//    func bind (model: [String]){
//        //  guard let nameURL = URL(string: model) else { return }
//        let calendar = Calendar.current
//        let day = calendar.component(.day, from: date)
//
//        for i in 0...model.count - 1 {
//          //  print(day)
//
//
//            if (model[i] == "\(day)"){
//                print(model[i])
//                selectImg.image = UIImage(named: "dataShapeDateYellow")
//                print("dataShapeDateYellow")
//                dayOfWeekLabel.textColor = .white
//                dayLabel.textColor = .white
//            }
//            else{
//                print(model[i])
//                selectImg.image = UIImage(named: "dataShapeDateWhite")
//                print("dataShapeDateWhite")
//                dayOfWeekLabel.textColor = .noname
//                dayLabel.textColor = .charcoal
//            }
//        }
//    }
//
}
