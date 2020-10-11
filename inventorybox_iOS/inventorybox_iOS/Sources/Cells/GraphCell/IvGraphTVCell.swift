//
//  IvGraphTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class IvGraphTVCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet var ivChartView: BarChartView!
    @IBOutlet var itemImg: UIImageView!
    @IBOutlet var itemAlarmCountLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var roundView: UIView!
    var accessCell:ItemInfo?
    
    private var stockArray:[Int] = [1,1,1,1,1,1,1]
    private var limitLine: ChartLimitLine?
    private var limitCount:Int?
    
    var months = ["일","월","화","수","목","금","토"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivChartView.delegate = self
        roundView.layer.cornerRadius = 9
        roundView.layer.shadowRadius = 9
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func bind (model:ItemInfo){
        //  guard let nameURL = URL(string: model) else { return }
        
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
        
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        var dataPoints: [String] = ["일","월","화","수","목","금","토"]
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0...6 {
            
            stockArray[i] = model.stocks[i]
            //print(stockArray[i])
            
            if stockArray[i] < 0 {
                stockArray[i] = 0
            }
            //print(stockArray[i])
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(stockArray[i]))
            dataEntries.append(dataEntry)
        }
        
        
        //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
        let chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        chartData.setValueFont(NSUIFont(name: "NanumSquare-Bold", size: 12.0) ?? UIFont.systemFont(ofSize: 12))
        chartData.setValueTextColor(.charcoal)
        
       
        ivChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
       
        
        let url = URL(string: model.iconImg)
        itemImg.kf.setImage(with: url)
        itemAlarmCountLabel.text = "\(model.alarmCnt)"
        limitCount = model.alarmCnt
        itemNameLabel.text = model.name
        
        //그래프 색 변경 부분
        
        //print(model.stocks[1])
        
        for i in 0..<model.stocks.count {
            chartDataSet.colors = [setColor(value: Double(model.stocks[i]))]
        }
        
       
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
        let  xAxis : XAxis = self.ivChartView.xAxis
        xAxis.labelFont = UIFont(name: "NanumSquare-ExtraBold", size: 12.0) ?? UIFont.systemFont(ofSize: 12)
        xAxis.labelTextColor = .charcoal
        
        xAxis.axisLineWidth = 0.5
        xAxis.axisLineColor = .pinkishGrey
        
        
        //밑에 데이터셋 제거
        ivChartView.legend.enabled = false
        
        chartData.barWidth = 0.3
        
        let ll = ChartLimitLine(limit: Double(model.alarmCnt), label: "")
        ll.lineColor = UIColor(red: 250/255, green: 221/255, blue: 155/255, alpha: 1.0)
        limitLine = ll
        ivChartView.rightAxis.removeLimitLine(ll)
        ivChartView.rightAxis.addLimitLine(ll)
        ll.lineWidth = 1.0
        
    }
        
    
    func removeLimitLine() {
        guard let limitLine = self.limitLine else { return }
        ivChartView.rightAxis.removeLimitLine(limitLine)
    }
    
    func setColor(value: Double) -> UIColor {
        
        if (value <= Double(limitCount!)) {
            return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
        }
        
        return UIColor(white: 206.0 / 255.0, alpha: 1.0)
        
    }
}
