//
//  IvDetailGraphSecondCompareVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvDetailGraphSecondCompareVC: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnCustom()
        // Do any additional setup after loading the view.
    }
    

    private func setBtnCustom(){
        confirmBtn.layer.cornerRadius = 25
        confirmBtn.backgroundColor = UIColor.yellow
        confirmBtn.tintColor = UIColor.white
    }
    
    @IBAction func dismissDatePicker(_sender:UIButton){
        let dateFormatter = DateFormatter()
                 
                 dateFormatter.dateFormat = "yyyy"
                 let year: String = dateFormatter.string(from: datePicker.date)
                 
                 dateFormatter.dateFormat = "M"
                 let month:String = dateFormatter.string(from: datePicker.date)
                 
                 dateFormatter.dateFormat = "dd"
                 let day:String = dateFormatter.string(from: datePicker.date)
               
               let calendar = Calendar.current
              // calendar.component(.year, from: datePicker.date)
               //calendar.component(.month, from: datePicker.date)
               
               
               dateFormatter.dateFormat = "ww"
               let week:String = "\(calendar.component(.weekOfMonth, from: datePicker.date))"
               print(week)
                 
               NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["secondYear": year, "secondMonth":month, "secondDay":day, "secondWeek":week])
                 
                 self.dismiss(animated: true, completion: nil)
    }

}
