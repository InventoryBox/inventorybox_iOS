//
//  HomeNewDetailContentTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts


class HomeNewDetailContentTVCell: UITableViewCell {
    
    @IBOutlet var ivGraphView: BarChartView!
    @IBOutlet var alarmCntLabel: UILabel!
    var stockArray : [Int] = [1,1,1,1,1]
    private var limitLine: ChartLimitLine?
    private var limitCount:Int?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind (model:HomeItem){
        //  guard let nameURL = URL(string: model) else { return }
        
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
        
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        
        
        //오늘 날짜 기준으로 -5일만..!
        
        let date = Date()
        let dateformatting = DateFormatter()
        dateformatting.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        
        var dataPoints: [String] = ["일","월","화","수","목"]
        
        //weekday; 1--일요일, 2--월요일, 3--화요일, 4--수요일, 5--목요일, 6--금요일, 7--토요일
        if weekday == 1 {
            dataPoints = ["수","목","금","토","일"]
        }else if weekday == 2 {
            dataPoints = ["목","금","토","일","월"]
        }else if weekday == 3 {
            dataPoints = ["금","토","일","월","화"]
        }else if weekday == 4 {
            dataPoints = ["토","일","월","화","수"]
        }else if weekday == 5 {
            dataPoints = ["일","월","화","수","목"]
        }else if weekday == 6 {
            dataPoints = ["월","화","수","목","금"]
        }else{
            dataPoints = ["화","수","목","금","토"]
        }
       
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0...4 {
            
           stockArray[i] = model.stocksInfo[i]
            
            if stockArray[i] < 0 {
                stockArray[i] = 0
            }
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(stockArray[i]))
            dataEntries.append(dataEntry)
        }
        
        
        //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
        let chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        chartData.setValueFont(NSUIFont(name: "NanumSquare-Bold", size: 12.0) ?? UIFont.systemFont(ofSize: 12))
        chartData.setValueTextColor(.charcoal)
        
       
        ivGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
       
        
        limitCount = model.alarmCnt
        
        //그래프 색 변경 부분
        
        //print(model.stocks[1])
        
        chartDataSet.colors = [setColor(value: Double(model.stocksInfo[0])),setColor(value: Double(model.stocksInfo[1])),setColor(value: Double(model.stocksInfo[2])),setColor(value: Double(model.stocksInfo[3])),setColor(value: Double(model.stocksInfo[4]))]
        
//        for i in 0..<model.stocksInfo.count {
//            chartDataSet.colors = [setColor(value: Double(model.stocksInfo[i]))]
//        }

    
        ivGraphView.data = chartData
        ivGraphView.xAxis.labelPosition = .bottom
        ivGraphView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        ivGraphView.xAxis.labelCount = dataPoints.count
        ivGraphView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        ivGraphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        ivGraphView.xAxis.drawGridLinesEnabled = false
        ivGraphView.leftAxis.drawLabelsEnabled = false
        ivGraphView.rightAxis.drawGridLinesEnabled = false
        ivGraphView.rightAxis.drawLabelsEnabled = false
        ivGraphView.leftAxis.drawAxisLineEnabled = false
        ivGraphView.rightAxis.drawAxisLineEnabled = false
        ivGraphView.leftAxis.drawGridLinesEnabled = false
        ivGraphView.drawGridBackgroundEnabled = false
        ivGraphView.drawBordersEnabled = false
        let  xAxis : XAxis = self.ivGraphView.xAxis
        xAxis.labelFont = UIFont(name: "NanumSquare-ExtraBold", size: 12.0) ?? UIFont.systemFont(ofSize: 12)
        xAxis.labelTextColor = .charcoal
        xAxis.axisLineWidth = 0.5
        xAxis.axisLineColor = .pinkishGrey
        
        xAxis.labelRotatedWidth = 211
        
        // view offset 왼쪽에서 100 띄우기
       ivGraphView.setViewPortOffsets(left: 0, top: 12, right: 0, bottom: 16)
        
        
        //밑에 데이터셋 제거
        ivGraphView.legend.enabled = false
        
        chartData.barWidth = 0.25
        
        let ll = ChartLimitLine(limit: Double(model.alarmCnt), label: "")
        ll.lineColor = UIColor(red: 250/255, green: 221/255, blue: 155/255, alpha: 1.0)
        limitLine = ll
        ivGraphView.rightAxis.removeLimitLine(ll)
        ivGraphView.rightAxis.addLimitLine(ll)
        ll.lineWidth = 1.0
        
    }
        
    
    func removeLimitLine() {
        guard let limitLine = self.limitLine else { return }
        ivGraphView.rightAxis.removeLimitLine(limitLine)
    }
    
    func setColor(value: Double) -> UIColor {
        
        if (value <= Double(limitCount!)) {
            return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
        }
        
        return UIColor(white: 206.0 / 255.0, alpha: 1.0)
        
    }
    

}
