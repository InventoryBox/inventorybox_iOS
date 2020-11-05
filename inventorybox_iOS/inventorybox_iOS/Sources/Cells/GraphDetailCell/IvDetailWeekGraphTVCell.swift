//
//  IvDetailWeekGraphTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class IvDetailWeekGraphTVCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet var weekInfoLabel: UILabel!
    @IBOutlet var firstMonthInfoLabel: UILabel!
    @IBOutlet var firstDayLabel:UILabel!
    @IBOutlet var secondDayInfoLabel: UILabel!
    @IBOutlet var secondMonthLabel: UILabel!
    @IBOutlet var ivChartView: BarChartView!
    @IBOutlet var roundView: UIView!
    private var limitLine: ChartLimitLine?
    var itemIdx:Int?
    

    var months = ["일","월","화","수","목","금","토"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivChartView.delegate = self
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.cornerRadius = 9
        roundView.layer.shadowRadius = 9
        roundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        firstMonthInfoLabel.sizeToFit()
        firstDayLabel.sizeToFit()
        secondDayInfoLabel.sizeToFit()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
    func bindGraph(model:GraphInfo,alarmCount:Int, weekLabel:String, itemIndex:Int, monthInfo:String){
        
        
        
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
        
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        firstDayLabel.text = model.startDay
        secondMonthLabel.text = model.endDay
    
  
        itemIdx = itemIndex
        weekInfoLabel.text = weekLabel
        
        var dataPoints: [String] = ["일","월","화","수","목","금","토"]
        var dataEntries : [BarChartDataEntry] = []
        
        //dataPoint.count (배열의 값만큼 막대가 생긴다)
        for i in 0 ... months.count - 1{
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(model.stocks[i]))
                   dataEntries.append(dataEntry)
                  // print(Int(values[i]))
               }
               
               
               //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
               let chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
               
               
               //그래프 색 변경 부분
               
             //  print(values[1])
            chartDataSet.colors = [setColor(value: Double(model.stocks[0])),setColor(value: Double(model.stocks[1])),setColor(value: Double(model.stocks[2])),setColor(value: Double(model.stocks[3])),setColor(value: Double(model.stocks[4])),setColor(value: Double(model.stocks[5])),setColor(value: Double(model.stocks[6]))]
               
               
               let chartData = BarChartData(dataSet: chartDataSet)
               chartData.setValueFormatter(formatter)
               ivChartView.data = chartData
               ivChartView.xAxis.labelPosition = .bottom
               ivChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
               ivChartView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        
               ivChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
               ivChartView.xAxis.drawGridLinesEnabled = false
               ivChartView.leftAxis.drawLabelsEnabled = false
               ivChartView.rightAxis.drawGridLinesEnabled = false
               ivChartView.rightAxis.drawLabelsEnabled = false
               ivChartView.leftAxis.drawAxisLineEnabled = false
               ivChartView.rightAxis.drawAxisLineEnabled = false
               ivChartView.leftAxis.drawGridLinesEnabled = false
               ivChartView.drawGridBackgroundEnabled = false
               ivChartView.drawBordersEnabled = false
               
               //밑에 데이터셋 제거
               ivChartView.legend.enabled = false
               
               chartData.barWidth = 0.2
        
               let ll = ChartLimitLine(limit: Double(alarmCount), label: "")
               limitLine = ll
               ivChartView.rightAxis.removeLimitLine(ll)
               ivChartView.rightAxis.addLimitLine(ll)
               ll.lineWidth = 0.3
               
               
            
               
               //그래프 색 변경 부분
               
               
              
        
    }
    
    
    
    func limitDraw(limitCount:Double){
        let ll = ChartLimitLine(limit: limitCount, label: "")
        ivChartView.rightAxis.addLimitLine(ll)
        ll.lineWidth = 0.3
    }
    
    
    func setColor(value: Double) -> UIColor {
        if (value <= 3.0) {
            return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
        }
        
        return UIColor(white: 206.0 / 255.0, alpha: 1.0)
        
        
    }
    
    


}
