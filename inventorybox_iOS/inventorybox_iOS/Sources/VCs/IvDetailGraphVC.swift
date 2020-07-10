//
//  IvDetailGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvDetailGraphVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var backgroundPopupView: UIView!

    var weekArray:[DetailGraphWeekInfo] = []
   
    // 이 값 순서대로 그래프가 그려짐
    // 서버통신 시 inventory별 정보 배열이 들어갈 곳
    let uniteSold = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    var numbers:[Double] = []
    var days: [String]!
    
    
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
     

    }
    
    
    func setWeek(){
        
        days = ["일","월","화","수","목","금","토"]
           
//        for _ in 1...7 {
//              weekArray.append( DetailGraphWeekInfo(weekLabel:"weekLabel.text", firstMonth: "1", firstDay: "1", secondMonth: "1", secondDay: "1", itemAlarmCount: 1.0, dataPoints: days, values: uniteSold))
//        }
        
        let firstWeek = DetailGraphWeekInfo(weekLabel: "1주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: uniteSold)
        let secondWeek = DetailGraphWeekInfo(weekLabel: "2주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: uniteSold)
        let thirdWeek = DetailGraphWeekInfo(weekLabel: "3주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: uniteSold)
        let fourthWeek = DetailGraphWeekInfo(weekLabel: "4주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: uniteSold)
        let fifthWeek = DetailGraphWeekInfo(weekLabel: "5주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: uniteSold)
        let sixthWeek = DetailGraphWeekInfo(weekLabel: "6주차", firstMonth: "5", firstDay: "21", secondMonth: "5", secondDay: "27", itemAlarmCount: 3.0, dataPoints: days, values: uniteSold)
        
        weekArray = [firstWeek,secondWeek,thirdWeek,fourthWeek,fifthWeek,sixthWeek]
      
       }
    
    
    @IBAction func popUpDatePickerBtn(_ sender: UIButton) {
        
        animatePopupBackground(true)
              guard let vc = storyboard?.instantiateViewController(withIdentifier: "DatePickerPopupVC") else { return }
              vc.modalPresentationStyle = .overCurrentContext
              self.present(vc, animated: true)
    }
    
    private func setPopupBackgroundView() {
           
           backgroundPopupView.isHidden = true
           backgroundPopupView.alpha = 0
           self.view.bringSubviewToFront(backgroundPopupView)
           NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
           
       }
       
       func animatePopupBackground(_ direction: Bool) {
           
           let duration: TimeInterval = direction ? 0.35 : 0.15
           let alpha: CGFloat = direction ? 0.54 : 0.0
           self.backgroundPopupView.isHidden = !direction
           UIView.animate(withDuration: duration) {
               self.backgroundPopupView.alpha = alpha
           }
           
       }
       
       @objc func didDisappearPopup(_ notification: Notification) {
           
           guard let info = notification.userInfo as? [String: Any] else { return }
           guard let date = info["selectdDate"] as? String else { return }
           print(date)
      //  monthPickLabel.text = date
           animatePopupBackground(false)
       }
       
       deinit {
           NotificationCenter.default.removeObserver(self)
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekArray.count
       }
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailGraphTVHeaderCell") as! IvDetailGraphTVHeaderCell
                
                
                return headerCell
            }
                
            else {
                guard let weekGraphCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailWeekGraphTVCell", for:indexPath) as? IvDetailWeekGraphTVCell else {return UITableViewCell()}
                
                weekGraphCell.setIvGraphTV(weekLabel: weekArray[indexPath.row - 1].weekLabel!, firstMonth: weekArray[indexPath.row - 1].firstMonth!, firstDay: weekArray[indexPath.row - 1].firstDay!, secondMonth: weekArray[indexPath.row - 1].secondMonth!, secondDay: weekArray[indexPath.row - 1].secondDay!, itemAlarmCount: weekArray[indexPath.row - 1].itemAlarmCount!, dataPoints: weekArray[indexPath.row - 1].dataPoints!, values: weekArray[indexPath.row - 1].values!)
                
                
                return weekGraphCell
            }
        }
            
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvWeekCompareGraphTVCell") as! IvWeekCompareGraphTVCell
            
            
            return cell
            
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvEditTVCell") as! IvEditTVCell
            
            return cell
        }
    
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
