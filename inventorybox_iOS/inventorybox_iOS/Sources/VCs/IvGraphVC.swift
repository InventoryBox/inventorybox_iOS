//
//  IvGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts
import TTGTagCollectionView

class IvGraphVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, TTGTextTagCollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet var headerView: UIView!
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var categoryTabView: TTGTextTagCollectionView!
    @IBOutlet var ivDataTableView: UITableView!
    
    
    
    private var DayList:[DayInformation] = []
    private var itemList:[ItemInformation] = []

    
    var numbers:[Double] = []
    var days: [String]!
       
    
    // 이 값 순서대로 그래프가 그려짐
    // 서버통신 시 inventory별 정보 배열이 들어갈 곳
    let uniteSold = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //view에 shadow
        headerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        headerView.layer.shadowOpacity = 0.08
        
    
        //collectionView 정의
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.layer.cornerRadius = 10
//        calendarCollectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0) as! CGColor
        calendarCollectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        calendarCollectionView.layer.shadowOpacity = 0.1
        calendarCollectionView.layer.shadowRadius = 3
        calendarCollectionView.clipsToBounds = false
        calendarCollectionView.layer.masksToBounds = false
        
        
        //카테고리 탭뷰
        categoryTabView.delegate = self
        categoryTabView.alignment = .left
        categoryTabView.scrollDirection = .horizontal
        
        let config = TTGTextTagConfig()
        config.textColor = UIColor(red: 65.0 / 255.0, green: 71.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
        config.borderColor = UIColor(white: 230.0 / 255.0, alpha: 1.0)
        config.backgroundColor = .white
        config.borderWidth = 1.3
        config.cornerRadius = 20
        config.exactHeight = 24
        config.extraSpace = CGSize(width: 8, height: 0)
        
        config.selectedBorderColor = UIColor(red: 71.0 / 255.0, green: 69.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
        config.selectedTextColor = .white
        config.selectedBorderWidth = 1.3
        config.selectedCornerRadius = 20
        config.selectedBackgroundColor = UIColor(red: 71.0 / 255.0, green: 69.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
        
        config.shadowOpacity = 0
        
        
        categoryTabView.addTags([" 전체 "," 액체류 "," 파우더류 "," 과일 "," 채소류 ", " 카트 ", " 오류다아아 "], with: config)
   
        //day 데이터 setting
        setDayList()
        
        
        
        //tableView
        ivDataTableView.delegate = self
        ivDataTableView.dataSource = self
        
        
        //item 데이터 setting
        setItemList()

    }
    
    
    
    
     private func setDayList(){
        
        
        var dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        var currentDayString = dayFormatter.string(from: Date())
        print(currentDayString)
        
        
        
        var daylist:[String] = ["05","06","07","08","09","10","11"]
        var today:Bool = true
        
        for i in 0...6 {
            if daylist[i] == currentDayString {
//                DayList[i].isToday = today
//                DayList[i].currentDay = daylist[i]
                today = true
                print(today)
            }
            else {
                today = false
                print(today)
            }
        }
        
         let sunday = DayInformation(currentDay:"05", currentWeekOfDay: "일", isToday: false)
         let monday = DayInformation(currentDay: "06" ,currentWeekOfDay: "월", isToday: false)
         let tuesday = DayInformation(currentDay:"07", currentWeekOfDay: "화", isToday: true)
         let wednesday = DayInformation(currentDay:"08", currentWeekOfDay: "수", isToday: false)
         let thursday = DayInformation(currentDay:"09" , currentWeekOfDay: "목", isToday: false)
         let friday = DayInformation(currentDay:"10", currentWeekOfDay: "금", isToday: false)
         let saturday = DayInformation(currentDay:"11" , currentWeekOfDay: "토", isToday: false)
        
    
         //위에 만들어놓은 빈 배열인 profileList에 profile1(데이터)을 넣어준다.
         DayList = [sunday,monday,tuesday,wednesday,thursday,friday,saturday]
        print(DayList)
      
         
     }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCVCell
        
        cell.setDayInformation(dayOfWeek: DayList[indexPath.row].currentWeekOfDay, day: DayList[indexPath.row].currentDay!, isToday: DayList[indexPath.row].isToday!)
    
             return cell
    }
    
    
    
    
    
    private func setItemList(){
     
        days = ["일","월","화","수","목","금","토"]
        
        let milk = ItemInformation(itemImg: "lastrecordingIcMilk", itemName: "우유", itemAlarmCount: 4.0, dataPoints: days, values: uniteSold)
            
         let iceCup = ItemInformation(itemImg: "dataIcCup", itemName: "아이스컵 12oz", itemAlarmCount: 2.0, dataPoints: days, values: uniteSold)
        
         let coffee = ItemInformation(itemImg: "dataIcCoffee", itemName: "커피", itemAlarmCount: 5.0, dataPoints: days, values: uniteSold)
        
         let brownMilk = ItemInformation(itemImg: "dataIcMcpowder", itemName: "우유", itemAlarmCount: 6.0, dataPoints: days, values: uniteSold)

        
             //위에 만들어놓은 빈 배열인 profileList에 profile1(데이터)을 넣어준다.
             itemList = [milk,iceCup,coffee,brownMilk,milk,iceCup,coffee,brownMilk]
      
          
             
         }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //셀 재사용 문제 해결하기
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemDataCell", for:indexPath) as! IvGraphTVCell
        
        
        cell.setIvGraphTV(itemImage: itemList[indexPath.row].itemImg!, itemName: itemList[indexPath.row].itemName!, itemCount: itemList[indexPath.row].itemAlarmCount!, dataPoints: itemList[indexPath.row].dataPoints!, values: itemList[indexPath.row].values!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        //기기 사이즈 맞춰서 142 생각하기
        
        return 142
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        
        let headerView = UIView()
               if section == 0{
                   
                  var friendsLabel = UILabel(frame: CGRect(x: 16, y: 9.5, width:tableView.bounds.size.width, height: 17))
                   
                   friendsLabel.font = UIFont(name: "KoPubWorldDotumPM", size: 11)
                   friendsLabel.textColor = UIColor.lightGray
                   friendsLabel.text = "경고"
                   friendsLabel.sizeToFit()
                   headerView.addSubview(friendsLabel)
                   
               }
               return headerView
           }
       

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var size:Int = 0
        
        if section == 0{
            
            size = 50
            return CGFloat(size)
        }
        
        
        return CGFloat(size)
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
