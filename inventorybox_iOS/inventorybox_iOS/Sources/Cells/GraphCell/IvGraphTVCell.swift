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
    
    var months = ["일","월","화","수","목","금","토"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivChartView.delegate = self
    
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setIvGraphTV(itemImage:String,itemName:String,itemCount:Double,dataPoints: [String], values: [Double]){
        
       
        var dataEntries : [BarChartDataEntry] = []
        
        itemNameLabel.text = itemName
        itemImg.image = UIImage(named:itemImage)
        itemAlarmCountLabel.text = "\(Int(itemCount))"
       
                
        //dataPoint.count (배열의 값만큼 막대가 생긴다)
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            print(Int(values[i]))
        }
        
        
        
        //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
        let chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
        
        
        
        
        //그래프 색 변경 부분
        
        print(values[1])
        chartDataSet.colors = [setColor(value: values[0]),setColor(value: values[1]),setColor(value: values[2]),setColor(value: values[3]),setColor(value: values[4]),setColor(value: values[5]),setColor(value: values[6])]
        
        
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        ivChartView.data = chartData
        ivChartView.xAxis.labelPosition = .bottom
        ivChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        
        ivChartView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        ivChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        
        let ll = ChartLimitLine(limit: itemCount, label: "")
        ivChartView.rightAxis.addLimitLine(ll)
        ll.lineWidth = 0.3
        
        
        ivChartView.xAxis.drawGridLinesEnabled = false
        ivChartView.leftAxis.drawLabelsEnabled = false
        ivChartView.rightAxis.drawGridLinesEnabled = false
        ivChartView.rightAxis.drawLabelsEnabled = false
        ivChartView.leftAxis.drawAxisLineEnabled = false
        ivChartView.rightAxis.drawAxisLineEnabled = false
        ivChartView.leftAxis.drawGridLinesEnabled = false
     
        ivChartView.drawGridBackgroundEnabled = false
        ivChartView.drawBordersEnabled = false

   
        
        ivChartView.leftAxis.drawZeroLineEnabled = false
        
        chartData.barWidth = 0.2
        
          
      }
    
    
    func setColor(value: Double) -> UIColor {
        if (value <= 3.0) {
            return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
        }

            return UIColor(white: 206.0 / 255.0, alpha: 1.0)
        
       
    }
    

}