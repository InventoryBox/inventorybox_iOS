//
//  IvDetailGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class IvDetailGraphVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var backgroundPopupView: UIView!
    @IBOutlet var popupBackgroundView: UIView!
    var isClickedBtn:Bool?
    var weekArray:[DetailGraphWeekInfo] = []
    var reloadArray:[DetailGraphWeekInfo] = []
    var doubleGraphArray:[DetailCompareGraphInfo] = []
    var itemName:String?
    var isSelected:[Bool] = []
    var selectedFirstYearTextField:String = ""
    var selectedFirstMonthTextField:String = ""
    var selectedFirstWeekTextField:String = ""
    var selectedSecondYearTextField:String = ""
    var selectedSecondMonthTextField:String = ""
    var selectedSecondWeekTextField:String = ""
    var itemIdx:Int?
    var compareGraphWeek1Array:[Int] = [0,0,0,0,0,0,0]
    var compareGraphWeek2Array:[Int] = [0,0,0,0,0,0,0]


    
    // 이 값 순서대로 그래프가 그려짐
    // 서버통신 시 inventory별 정보 배열이 들어갈 곳
    let singleGraphUniteSold = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    
    let doubleGraphUniteSold1 = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    let doubleGraphUniteSold2 = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
//
//    var numbers:[Double] = []
//    var graph2Numbers:[Double] = []
    
    var days: [String]!
    var graph2Days:[String]!
    
    
    var clickBtnWeek:Int?
    var whatWeekIs:String?
    
    @IBOutlet var ivDetilTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //네비게이션 바 나타나게 하는 코드
        self.navigationController?.navigationBar.isHidden = false
        ivDetilTV.delegate = self
        ivDetilTV.dataSource = self
        setWeek()
        setGraph2()
        self.navigationItem.title = itemName
        reloadArray = weekArray
        ivDetilTV.allowsSelection = false
        ivDetilTV.separatorStyle = .none
        ivDetilTV.contentInsetAdjustmentBehavior = .never
        setPopupBackgroundView()
       
        NotificationCenter.default.addObserver(self, selector: #selector(setWeeks(_:)), name: .clickWeek, object: nil)
    }
    
    @objc func setWeeks(_ notification: NSNotification) {
        guard let row = notification.userInfo?["week"] as? Int else { return }
        guard let status = notification.userInfo?["status"] as? Bool else { return }
//        print(row)
//        print(status)
        clickBtnWeek = row
        print("notiLoading")
        print("dd\(status)")
        
        // 초기 상태값으로 움직임
        if status == false {
            for i in 0...weekArray.count - 1{
                if clickBtnWeek == i  {
                    reloadArray.remove(at: i)
                    print(reloadArray)
                    self.reloadArray.sort{$0.itemIndex! < $1.itemIndex!}
                    print(reloadArray)
                    ivDetilTV.reloadData()
                }
            }
        }
       
        else {
            for i in 0...weekArray.count - 1{
                if clickBtnWeek == i {
                    reloadArray.append(weekArray[i])
                    print(reloadArray)
                    self.reloadArray.sort{$0.itemIndex! < $1.itemIndex!}
                    print(reloadArray)
                    ivDetilTV.reloadData()
                }
            }
        }
        
    }
    

       private func setPopupBackgroundView() {
           
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSecondDisappearPopup), name: .init("popup"), object: nil)
        
    }
    
       
       func animatePopupBackground(_ direction: Bool) {
           
           let duration: TimeInterval = direction ? 0.35 : 0.15
           let alpha: CGFloat = direction ? 0.54 : 0.0
           self.popupBackgroundView.isHidden = !direction
           UIView.animate(withDuration: duration) {
               self.popupBackgroundView.alpha = alpha
           }
           
       }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let year = info["year"] as? String else { return }
        guard let month = info["month"] as? String else {return}
        guard let week = info["week"] as? String else {return}

        
        selectedFirstYearTextField = year
        selectedFirstMonthTextField = month
        selectedFirstWeekTextField = week

      
        print(selectedFirstMonthTextField)

        ivDetilTV.reloadData()
 
       }
    
     @objc func didSecondDisappearPopup(_ notification: Notification) {
            
            animatePopupBackground(false)
            guard let info = notification.userInfo as? [String: Any] else { return }
           
            guard let secondYear = info["secondYear"] as? String else {return}
            guard let secondMonth = info["secondMonth"] as? String else {return}
            guard let secondWeek = info["secondWeek"] as? String else {return}

            selectedSecondYearTextField = secondYear
            selectedSecondMonthTextField = secondMonth
            selectedSecondWeekTextField = secondWeek
          

            print(selectedSecondMonthTextField)
            
            ivDetilTV.reloadData()
     
           }
  

    
    @IBAction func dayPickerBtn(_ sender: UIButton) {
        animatePopupBackground(true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvCompareGraphVC") as? IvCompareGraphVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func secondDatePickerBtn(_ sender: UIButton) {
        animatePopupBackground(true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvDetailGraphSecondCompareVC") as? IvDetailGraphSecondCompareVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func compareBtn(_ sender: UIButton) {
        InventoryCompareGraphService.shared.loadCompareGraph(itemIdx!, Int(selectedFirstYearTextField)!, Int(selectedFirstMonthTextField)!, Int(selectedFirstWeekTextField)!, Int(selectedSecondYearTextField)!, Int(selectedSecondMonthTextField)!, Int(selectedSecondWeekTextField)!, completion: { networkResult in
            switch networkResult{
            case .success(let token):
                print(token)
                guard let data = token as? CompareWeekData else {return}
                self.compareGraphWeek1Array = data.week1
                self.compareGraphWeek2Array = data.week2
                DispatchQueue.main.async {
                    self.ivDetilTV.reloadData()
                }
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        })
        
    }
    
//    func getDataFromServer(){
//
//           InventoryGraphHomeService.shared.loadHome { networkResult in
//               switch networkResult{
//               case .success(let token):
//                   print(token)
//                   guard let data = token as? ThisWeekData else {return}
//                   self.dayList = data.thisWeekDates
//                   print(self.dayList)
//                   self.itemList = data.itemInfo
//                   self.tagArray = data.categoryInfo
//                   print(self.tagArray.count)
//                   print(self.tagArray)
//                   DispatchQueue.main.async {
//                       self.calendarCollectionView.reloadData()
//                       self.tagCollectionView.reloadData()
//                   }
//               case .requestErr(let message):
//                   guard let message = message as? String else {return}
//                   print(message)
//               case .serverErr: print("serverErr")
//               case .pathErr:
//                   print("pathErr")
//               case .networkFail:
//                   print("networkFail")
//               }
//
//
//           }
//       }
//
    func setGraph2(){
        
        graph2Days = ["일","월","화","수","목","금","토"]

        
    
        let firstWeek = DetailCompareGraphInfo(yearTextField: selectedFirstYearTextField, monthTextField: selectedFirstMonthTextField, weekTextField: selectedFirstWeekTextField, secondYearTextField: selectedSecondYearTextField, secondMonthTextField: selectedSecondMonthTextField, itemAlarmCount: 4.0, secondWeekTextField: selectedSecondWeekTextField, dataPoints: graph2Days, values1: doubleGraphUniteSold1 )
        
        doubleGraphArray = [firstWeek]
        print(doubleGraphArray)
        
    }
    
    func setWeek(){
        
        days = ["일","월","화","수","목","금","토"]
           
        
        let firstWeek = DetailGraphWeekInfo(weekLabel: "1주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: singleGraphUniteSold,itemIndex: 0)
        let secondWeek = DetailGraphWeekInfo(weekLabel: "2주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: singleGraphUniteSold,itemIndex: 1)
        let thirdWeek = DetailGraphWeekInfo(weekLabel: "3주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: singleGraphUniteSold,itemIndex: 2)
        let fourthWeek = DetailGraphWeekInfo(weekLabel: "4주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: singleGraphUniteSold,itemIndex: 3)
        let fifthWeek = DetailGraphWeekInfo(weekLabel: "5주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: singleGraphUniteSold,itemIndex: 4)
        let sixthWeek = DetailGraphWeekInfo(weekLabel: "6주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: singleGraphUniteSold,itemIndex: 5)
        
        weekArray = [firstWeek,secondWeek,thirdWeek,fourthWeek,fifthWeek,sixthWeek]
        
       }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            if clickBtnWeek == 0 {
                       return reloadArray.count + 1
                   }
                   else if clickBtnWeek == 1 {
                       return reloadArray.count + 1
                   }
                   else if clickBtnWeek == 2 {
                       return reloadArray.count + 1
                   }
                   else if clickBtnWeek == 3 {
                       return reloadArray.count + 1
                   }
                   else if clickBtnWeek == 4 {
                       return reloadArray.count + 1
                   }
                   else if clickBtnWeek == 5 {
                       return reloadArray.count + 1
                   }
                   else {
                       return weekArray.count + 1
                   }
            
        }
        else if section == 1 {
            return 1
        }
        
        
            return 1
        
        
    }
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailGraphTVHeaderCell") as! IvDetailGraphTVHeaderCell
                
                
                return headerCell
            }
                
            else {
                guard let weekGraphCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailWeekGraphTVCell", for:indexPath) as? IvDetailWeekGraphTVCell else {return UITableViewCell()}
                
                
                if clickBtnWeek == 0 {
                    weekGraphCell.setIvGraphTV(weekLabel: reloadArray[indexPath.row - 1].weekLabel!, firstMonth: reloadArray[indexPath.row - 1].firstMonth!, firstDay: reloadArray[indexPath.row - 1].firstDay!, secondMonth: reloadArray[indexPath.row - 1].secondMonth!, secondDay: reloadArray[indexPath.row - 1].secondDay!, itemAlarmCount: reloadArray[indexPath.row - 1].itemAlarmCount!, dataPoints: reloadArray[indexPath.row - 1].dataPoints!, values: reloadArray[indexPath.row - 1].values!, itemIndex: reloadArray[indexPath.row - 1].itemIndex!)
                           
                       }
                       else if clickBtnWeek == 1 {
                    weekGraphCell.setIvGraphTV(weekLabel: reloadArray[indexPath.row - 1].weekLabel!, firstMonth: reloadArray[indexPath.row - 1].firstMonth!, firstDay: reloadArray[indexPath.row - 1].firstDay!, secondMonth: reloadArray[indexPath.row - 1].secondMonth!, secondDay: reloadArray[indexPath.row - 1].secondDay!, itemAlarmCount: reloadArray[indexPath.row - 1].itemAlarmCount!, dataPoints: reloadArray[indexPath.row - 1].dataPoints!, values: reloadArray[indexPath.row - 1].values!,itemIndex: reloadArray[indexPath.row - 1].itemIndex!)
                          
                       }
                       else if clickBtnWeek == 2 {
                    weekGraphCell.setIvGraphTV(weekLabel: reloadArray[indexPath.row - 1].weekLabel!, firstMonth: reloadArray[indexPath.row - 1].firstMonth!, firstDay: reloadArray[indexPath.row - 1].firstDay!, secondMonth: reloadArray[indexPath.row - 1].secondMonth!, secondDay: reloadArray[indexPath.row - 1].secondDay!, itemAlarmCount: reloadArray[indexPath.row - 1].itemAlarmCount!, dataPoints: reloadArray[indexPath.row - 1].dataPoints!, values: reloadArray[indexPath.row - 1].values!, itemIndex: reloadArray[indexPath.row - 1].itemIndex!)
                          
                       }
                       else if clickBtnWeek == 3 {
                  weekGraphCell.setIvGraphTV(weekLabel: reloadArray[indexPath.row - 1].weekLabel!, firstMonth: reloadArray[indexPath.row - 1].firstMonth!, firstDay: reloadArray[indexPath.row - 1].firstDay!, secondMonth: reloadArray[indexPath.row - 1].secondMonth!, secondDay: reloadArray[indexPath.row - 1].secondDay!, itemAlarmCount: reloadArray[indexPath.row - 1].itemAlarmCount!, dataPoints: reloadArray[indexPath.row - 1].dataPoints!, values: reloadArray[indexPath.row - 1].values!, itemIndex: reloadArray[indexPath.row - 1].itemIndex!)
                           
                       }
                       else if clickBtnWeek == 4 {
                  weekGraphCell.setIvGraphTV(weekLabel: reloadArray[indexPath.row - 1].weekLabel!, firstMonth: reloadArray[indexPath.row - 1].firstMonth!, firstDay: reloadArray[indexPath.row - 1].firstDay!, secondMonth: reloadArray[indexPath.row - 1].secondMonth!, secondDay: reloadArray[indexPath.row - 1].secondDay!, itemAlarmCount: reloadArray[indexPath.row - 1].itemAlarmCount!, dataPoints: reloadArray[indexPath.row - 1].dataPoints!, values: reloadArray[indexPath.row - 1].values!, itemIndex: reloadArray[indexPath.row - 1].itemIndex!)
                           
                       }
                       else if clickBtnWeek == 5 {
                    weekGraphCell.setIvGraphTV(weekLabel: reloadArray[indexPath.row - 1].weekLabel!, firstMonth: reloadArray[indexPath.row - 1].firstMonth!, firstDay: reloadArray[indexPath.row - 1].firstDay!, secondMonth: reloadArray[indexPath.row - 1].secondMonth!, secondDay: reloadArray[indexPath.row - 1].secondDay!, itemAlarmCount: reloadArray[indexPath.row - 1].itemAlarmCount!, dataPoints: reloadArray[indexPath.row - 1].dataPoints!, values: reloadArray[indexPath.row - 1].values!, itemIndex: reloadArray[indexPath.row - 1].itemIndex!)
                          
                       }
                else {
                    weekGraphCell.setIvGraphTV(weekLabel: weekArray[indexPath.row - 1].weekLabel!, firstMonth: weekArray[indexPath.row - 1].firstMonth!, firstDay: weekArray[indexPath.row - 1].firstDay!, secondMonth: weekArray[indexPath.row - 1].secondMonth!, secondDay: weekArray[indexPath.row - 1].secondDay!, itemAlarmCount: weekArray[indexPath.row - 1].itemAlarmCount!, dataPoints: weekArray[indexPath.row - 1].dataPoints!, values: weekArray[indexPath.row - 1].values!,itemIndex: weekArray[indexPath.row - 1].itemIndex!)
                }
                return weekGraphCell
            }
        }
            
            
        else if indexPath.section == 1 {
            let IvWeekCompareGraphTVCell = tableView.dequeueReusableCell(withIdentifier: "IvWeekCompareGraphTVCell") as! IvWeekCompareGraphTVCell
            
            print(selectedSecondWeekTextField)
               
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
                        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(compareGraphWeek1Array[i]))
                        dataEntries.append(dataEntry)
                        //print(model.stocks[i])
                    }
                    
                    for i in 0...6 {
                        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(compareGraphWeek2Array[i]))
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
                    
            IvWeekCompareGraphTVCell.compareChartView.data = data
                    
                    
            IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawGridLinesEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawAxisLineEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawLabelsEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                    
                   
                 
                    //그래프 색 변경 부분
                    
             
            //        chartDataSet.colors = [setColor(value: Double(model.wee[0])),setColor(value: Double(model.stocks[1])),setColor(value: Double(model.stocks[2])),setColor(value: Double(model.stocks[3])),setColor(value: Double(model.stocks[4])),setColor(value: Double(model.stocks[5])),setColor(value: Double(model.stocks[6]))]
            //
            graph2Days = ["일","월","화","수","목","금","토"]
                    
            IvWeekCompareGraphTVCell.compareChartView.xAxis.labelPosition = .bottom
            IvWeekCompareGraphTVCell.compareChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: graph2Days)
            IvWeekCompareGraphTVCell.compareChartView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
            IvWeekCompareGraphTVCell.compareChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            IvWeekCompareGraphTVCell.compareChartView.xAxis.drawGridLinesEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.leftAxis.drawLabelsEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawGridLinesEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawLabelsEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.leftAxis.drawAxisLineEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawAxisLineEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.leftAxis.drawGridLinesEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.drawGridBackgroundEnabled = false
            IvWeekCompareGraphTVCell.compareChartView.drawBordersEnabled = false
                    //    ivChartView.barData?.yMi
                    
                    //밑에 데이터셋 제거
            IvWeekCompareGraphTVCell.compareChartView.legend.enabled = false
                    
                    data.barWidth = 0.2
           
            
            return IvWeekCompareGraphTVCell
            
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvEditTVCell") as! IvEditTVCell
            
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 4
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
