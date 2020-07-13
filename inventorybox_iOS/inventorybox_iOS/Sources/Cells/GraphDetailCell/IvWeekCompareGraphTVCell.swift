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
    
    func setIvGraphTV(yearText:String,monthText:String,weekText:String,secondYearText:String,secondMonthText:String, secondWeekText:String,itemAlarmCount:Double,dataPoints: [String],values1: [Double]){
           
           
           var dataEntries : [BarChartDataEntry] = []
           var dataEntries2 : [BarChartDataEntry] = []
        
           yearTextField.text = yearText
           monthTextField.text = monthText
           weekTextField.text = weekText
           secondYearTextField.text = secondYearText
           secondMonthTextField.text = secondMonthText
           secondWeekTextField.text = secondWeekText

         
           //dataPoint.count (배열의 값만큼 막대가 생긴다)
           for i in 0..<dataPoints.count {
               let dataEntry = BarChartDataEntry(x: Double(i), y: values1[i])
              // let dataEntry2 = BarChartDataEntry(x: Double(i), y: values2[i])
               dataEntries.append(dataEntry)
             //  dataEntries2.append(dataEntry2)
              // print(Int(values[i]))
           }
           
           
           //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
           let chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
     //      let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "")
        
       

           //그래프 색 변경 부분
           
         //  print(values[1])
           chartDataSet.colors = [setColor(value: values1[0]),setColor(value: values1[1]),setColor(value: values1[2]),setColor(value: values1[3]),setColor(value: values1[4]),setColor(value: values1[5]),setColor(value: values1[6])]
        
            //   chartDataSet2.colors = [setColor(value: values2[0]),setColor(value: values2[1]),setColor(value: values2[2]),setColor(value: values2[3]),setColor(value: values2[4]),setColor(value: values2[5]), setColor(value: values2[6])]
           
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        //   chartData.groupBars(fromX: 1, groupSpace: 0.2, barSpace: 0.02)
           compareChartView.data = chartData
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
           
           //밑에 데이터셋 제거
           compareChartView.legend.enabled = false
           
           chartData.barWidth = 0.2
        
           let ll = ChartLimitLine(limit: itemAlarmCount, label: "")
           compareChartView.rightAxis.addLimitLine(ll)
           ll.lineWidth = 0.3
        
         
       }

       func setColor(value: Double) -> UIColor {
           if (value <= 3.0) {
               return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
           }
           
           return UIColor(white: 206.0 / 255.0, alpha: 1.0)
           
           
       }
    
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

    @IBAction func compareBtn(_ sender: UIButton) {
    }
}

extension UITextField {
  func addLeftPadding() {
  let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 9, height: self.frame.height))
  self.leftView = paddingView
  self.leftViewMode = ViewMode.always
    }
  }
