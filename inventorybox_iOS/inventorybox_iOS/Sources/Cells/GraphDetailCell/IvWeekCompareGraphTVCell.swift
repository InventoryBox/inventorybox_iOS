//
//  IvWeekCompareGraphTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class IvWeekCompareGraphTVCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet var yearTextField: UITextField!
    @IBOutlet var monthTextField: UITextField!
    @IBOutlet var weekTextField: UITextField!
    @IBOutlet var secondYearTextField: UITextField!
    @IBOutlet var secondMonthTextField: UITextField!
    @IBOutlet var secondWeekTextField: UITextField!
    @IBOutlet var compareChartView: BarChartView!
    @IBOutlet var compareBtn: UIButton!
    
    var months = ["일","월","화","수","목","금","토"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextFieldAttribute()
//        setTextField()
        compareBtn.layer.cornerRadius = 10.0
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

    
    func setTextFieldAttribute(){
        
        yearTextField.layer.cornerRadius = 9
        monthTextField.layer.cornerRadius = 9
        weekTextField.layer.cornerRadius = 9
        secondYearTextField.layer.cornerRadius = 9
        secondMonthTextField.layer.cornerRadius = 9
        secondWeekTextField.layer.cornerRadius = 9
        yearTextField.addLeftPadding()
        monthTextField.addLeftPadding()
        weekTextField.addLeftPadding()
        secondYearTextField.addLeftPadding()
        secondMonthTextField.addLeftPadding()
        secondWeekTextField.addLeftPadding()
    }
    
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 9, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addLeftPadding2() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
