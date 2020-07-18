//
//  HomeTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox
import Charts

class Home2TVCell: UITableViewCell {

    static let identifier : String = "Home2TVCell"
    var checkvalue : Bool = false   // checkbox
    var moreValue : Bool = false    // 더보기 버튼
    
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var moreBtn: UIButton!           // 더보기 버튼
    @IBOutlet weak var productImg: UIImageView!     // 제품 이미지
    @IBOutlet weak var productNameText: UILabel!    // 제품 이름
    @IBOutlet weak var productCountText: UILabel!   // 제품 개수
    @IBOutlet weak var productSetText: UILabel!     // 제품 묶음
    @IBOutlet weak var graphView: BarChartView!           // 그래프 나오는View
    @IBOutlet weak var checkBoxBtn: BEMCheckBox!
    private var limitLine: ChartLimitLine?
    private var limitCount:Int?
    var stockArray:[Int] = []
    
    
    var itemIdx: Int?
    var indexPath: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 첫 그래프 화면 숨기기
        graphView.isHidden = true
        
        
        makeShadowUnderView()
    }
     
    
    // checkBox눌렀을 때
    @IBAction func checkBoxPress(_ sender: Any) {
        if checkBoxBtn.on == false{ // 체크를 처음 눌렀을 때 On
            checkvalue = true
            
        }else{                  // // 체크를 풀었을 때 Off
            checkvalue = false
        }
        
        var isSelect: Int = 0
        if checkvalue {
            isSelect = 0
        } else {
            isSelect = 1
        }
        
        NotificationCenter.default.post(name: .init("tablevalue"), object: nil, userInfo: ["bool": checkBoxBtn.on, "name": productNameText.text!, "indexPath": indexPath!, "isSelect": isSelect])
        
        IvHomeFlagPostService.shared.getRecordEditIvPost(itemIdx: itemIdx!, flag: isSelect) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let graphData = data as? HomeItem else {return}
                self.stockArray = graphData.stocksInfo
                print(self.stockArray)
                
            case .requestErr(let msg):
                print(msg)
            case .pathErr:
                print("path")
                break
            case .serverErr:
                print("server")
                break
            case .networkFail:
                print("network")
                break
            }
        }
        
    }
    
    func bind (model:HomeItem){
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
        
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        var dataPoints: [String] = ["화","수","목","금","토"]
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0...4 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(model.stocksInfo[i]))
            dataEntries.append(dataEntry)
            //print(model.stocks[i])
        }
        
        
        //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
        let chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        
        graphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
        
       
        limitCount = model.alarmCnt
       
        
        //그래프 색 변경 부분
        
//        
//        chartDataSet.colors = [setColor(value: Double(model.stocksInfo[0])),setColor(value: Double(model.stocksInfo[1])),setColor(value: Double(model.stocksInfo[2])),setColor(value: Double(model.stocksInfo[3])),setColor(value: Double(model.stocksInfo[4])),setColor(value: Double(model.stocksInfo[5])),setColor(value: Double(model.stocksInfo[6]))]
        
        
        graphView.data = chartData
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        graphView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        graphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        graphView.xAxis.drawGridLinesEnabled = false
        graphView.leftAxis.drawLabelsEnabled = false
        graphView.rightAxis.drawGridLinesEnabled = false
        graphView.rightAxis.drawLabelsEnabled = false
        graphView.leftAxis.drawAxisLineEnabled = false
        graphView.rightAxis.drawAxisLineEnabled = false
        graphView.leftAxis.drawGridLinesEnabled = false
        graphView.drawGridBackgroundEnabled = false
        graphView.drawBordersEnabled = false
        //    ivChartView.barData?.yMi
        
        //밑에 데이터셋 제거
        graphView.legend.enabled = false
        
        chartData.barWidth = 0.2
        
        let ll = ChartLimitLine(limit: Double(model.alarmCnt), label: "")
        limitLine = ll
        graphView.rightAxis.removeLimitLine(ll)
        graphView.rightAxis.addLimitLine(ll)
        ll.lineWidth = 0.3
        
    }
    
    
    func removeLimitLine() {
        guard let limitLine = self.limitLine else { return }
        graphView.rightAxis.removeLimitLine(limitLine)
    }
    
    func setColor(value: Double) -> UIColor {
        
        if (value <= Double(limitCount!)) {
            return UIColor(red: 246.0 / 255.0, green: 187.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
        }
        
        return UIColor(white: 206.0 / 255.0, alpha: 1.0)
        
    }
    
    
    

    
    
    
    // 자세히 눌렀을 떄
    @IBAction func MorPressBtn(_ sender: Any) {
        if moreValue == false{  // 자세히 버튼 처음 눌렀을 떄
            graphView.isHidden = false
            moreBtn.setImage(UIImage(named: "homeBtnDetail02.png"), for: .normal)
            moreValue = true
        }else{
            moreBtn.setImage(UIImage(named: "homeBtnDetail01.png"), for: .normal)
            graphView.isHidden = true
            moreValue = false
        }
        NotificationCenter.default.post(name: .init("morepressbutton"), object: nil, userInfo: ["bool": moreValue, "name": productNameText.text!])
        
    }
   
    // Set 부분
    func SetProductImformation(productImage: String, productNameTx: String, productCountTx: Int, productSetTx: String, checkFlag: Int) {
        
        // URL을 이미지로 변환 시키기
        let url = URL(string: productImage)
        let data = try? Data(contentsOf: url!)
        productImg.image = UIImage(data: data!)
        
        productNameText.text = productNameTx
        productCountText.text = String(productCountTx)  // int형으로 받아야 함
        productSetText.text = productSetTx
        
        // 0,1로 들어오는 값을 true, false 값으로 바꾸기
        if checkFlag == 0 {
            checkvalue = false
        } else {
            checkvalue = true
        }
        checkBoxBtn.on = checkvalue
    }
    
    
    private func makeShadowUnderView() {
        // 그림자주는 코드
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 8// 퍼지는 정도
        
        roundView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}

