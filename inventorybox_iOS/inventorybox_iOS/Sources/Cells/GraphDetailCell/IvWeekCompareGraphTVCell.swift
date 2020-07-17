//
//  IvWeekCompareGraphTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class IvWeekCompareGraphTVCell: UITableViewCell {
    
    
    @IBOutlet var yearTextField: UITextField!
    @IBOutlet var monthTextField: UITextField!
    @IBOutlet var weekTextField: UITextField!
    @IBOutlet var secondYearTextField: UITextField!
    @IBOutlet var secondMonthTextField: UITextField!
    @IBOutlet var secondWeekTextField: UITextField!
    @IBOutlet var compareChartView: BarChartView!
    
    var months = ["일","월","화","수","목","금","토"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextFieldAttribute()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bind (model:CompareWeekData){
        //  guard let nameURL = URL(string: model) else { return }
        
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
        
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        var dataPoints: [String] = ["일","월","화","수","목","금","토"]
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        
        
        for i in 0...6 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(model.week1[i]))
            dataEntries.append(dataEntry)
            //print(model.stocks[i])
        }
        
        for i in 0...6 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(model.week2[i]))
            dataEntries2.append(dataEntry)
            //print(model.stocks[i])
        }
        
        
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: " ")
        let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: " ")
        
        chartDataSet2.colors =  [UIColor(red: 255/255, green: 70/255, blue: 108/255, alpha: 1)]
        
        chartDataSet.colors =  [UIColor(red: 49/255, green: 27/255, blue: 146/255, alpha: 1)]
        
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet2]
        let data = BarChartData(dataSets: dataSets)
        data.setValueFormatter(formatter)
        
        compareChartView.data = data
        
        
        compareChartView.rightAxis.drawGridLinesEnabled = false
        compareChartView.rightAxis.drawAxisLineEnabled = false
        compareChartView.rightAxis.drawLabelsEnabled = false
        compareChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
        
       
     
        //그래프 색 변경 부분
        
 
//        chartDataSet.colors = [setColor(value: Double(model.wee[0])),setColor(value: Double(model.stocks[1])),setColor(value: Double(model.stocks[2])),setColor(value: Double(model.stocks[3])),setColor(value: Double(model.stocks[4])),setColor(value: Double(model.stocks[5])),setColor(value: Double(model.stocks[6]))]
//
        
        compareChartView.xAxis.labelPosition = .bottom
        compareChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        compareChartView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        compareChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        compareChartView.xAxis.drawGridLinesEnabled = false
        compareChartView.leftAxis.drawLabelsEnabled = false
        compareChartView.rightAxis.drawGridLinesEnabled = false
        compareChartView.rightAxis.drawLabelsEnabled = false
        compareChartView.leftAxis.drawAxisLineEnabled = false
        compareChartView.rightAxis.drawAxisLineEnabled = false
        compareChartView.leftAxis.drawGridLinesEnabled = false
        compareChartView.drawGridBackgroundEnabled = false
        compareChartView.drawBordersEnabled = false
        //    ivChartView.barData?.yMi
        
        //밑에 데이터셋 제거
        compareChartView.legend.enabled = false
        
        data.barWidth = 0.2
//
//        let ll = ChartLimitLine(limit: Double(), label: "")
//        limitLine = ll
//        ivChartView.rightAxis.removeLimitLine(ll)
//        ivChartView.rightAxis.addLimitLine(ll)
//        ll.lineWidth = 0.3
        
    }
    
    
//    func removeLimitLine() {
//        guard let limitLine = self.limitLine else { return }
//        ivChartView.rightAxis.removeLimitLine(limitLine)
//    }
    
//    func setColor(value: Double) -> UIColor {
//
//        if (value <= Double(limitCount!)) {
//            return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
//        }
//
//        return UIColor(white: 206.0 / 255.0, alpha: 1.0)
//
//    }
//
    
    func setTextFieldAttribute(){
        
        yearTextField.layer.cornerRadius = 9
        monthTextField.layer.cornerRadius = 9
        weekTextField.layer.cornerRadius = 9
        secondYearTextField.layer.cornerRadius = 9
        secondMonthTextField.layer.cornerRadius = 9
        secondWeekTextField.layer.cornerRadius = 9
        
        yearTextField.layer.backgroundColor = CGColor(srgbRed: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        monthTextField.layer.backgroundColor = CGColor(srgbRed: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        weekTextField.layer.backgroundColor = CGColor(srgbRed: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        secondYearTextField.layer.backgroundColor = CGColor(srgbRed: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        secondMonthTextField.layer.backgroundColor = CGColor(srgbRed: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        secondWeekTextField.layer.backgroundColor = CGColor(srgbRed: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        
        
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
}
