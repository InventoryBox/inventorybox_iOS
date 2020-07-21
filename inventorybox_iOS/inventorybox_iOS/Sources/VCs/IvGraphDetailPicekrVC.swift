//
//  IvGraphDetailPicekrVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvGraphDetailPicekrVC: UIViewController {

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
    
    @IBAction func comfimBtn(_sender:UIButton) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: datePicker.date)
        
        dateFormatter.dateFormat = "M"
        let month:String = dateFormatter.string(from: datePicker.date)
        
        
        let calendar = Calendar.current
        
        
        dateFormatter.dateFormat = "ww"
        let week:String = "\(calendar.component(.weekOfMonth, from: datePicker.date))"
        print(week)
        
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["firstYear": year, "firstMonth":month])
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
