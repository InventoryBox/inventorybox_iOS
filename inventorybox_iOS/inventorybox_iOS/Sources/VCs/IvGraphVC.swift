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
    @IBOutlet var ivDataTableView: UITableView!
    @IBOutlet var tagCollectionView: UICollectionView!
    
    
    private var DayList:[DayInformation] = []
    private var itemList:[ItemInformation] = []
    private var tagArray:[TagModel] = []

    
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
        
       
        //day 데이터 setting
        setDayList()
        
        
        
        //tableView
        ivDataTableView.delegate = self
        ivDataTableView.dataSource = self
        
        
        //item 데이터 setting
        setItemList()
        
        
        //tableView 구분선 제거
        ivDataTableView.separatorStyle = .none
        self.navigationController?.navigationBar.isHidden = true
        
      
        //categoryTabView.selectionLimit = 1
        setTag()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func setTag(){
        let tag1 = TagModel(tagName: "전체")
        let tag2 = TagModel(tagName: "유제품")
        let tag3 = TagModel(tagName: "채소류")
        let tag4 = TagModel(tagName: "생선류")
        let tag5 = TagModel(tagName: "파우더류")
        let tag6 = TagModel(tagName: "과일")
        let tag7 = TagModel(tagName: "액체류")
        let tag8 = TagModel(tagName: "냉장고를 부탁해")
        
        
        tagArray = [tag1,tag2,tag3,tag4,tag5,tag6,tag7,tag8]
        print(tagArray)
        print(tagArray.count)
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
            }
            else {
                today = false
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
      
         
     }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == calendarCollectionView {
            return DayList.count
        }
        
        if collectionView == tagCollectionView {
            return tagArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == calendarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCVCell
            
            cell.setDayInformation(dayOfWeek: DayList[indexPath.row].currentWeekOfDay, day: DayList[indexPath.row].currentDay!, isToday: DayList[indexPath.row].isToday!)
            
            return cell
        }
        
        else if collectionView == tagCollectionView {
            let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionCell", for: indexPath) as! TagCollectionViewCell
            tagCell.tagNameLabel.text = tagArray[indexPath.row].tagName
            tagCell.backgroundColor = .white
            tagCell.layer.cornerRadius = 11
            
            tagCell.layer.borderColor = CGColor(srgbRed: 154/255, green: 154/255, blue: 154/255, alpha: 1.0)
            tagCell.layer.borderWidth = 0.5
            
            return tagCell
        }
        return UICollectionViewCell()
    }
    
    
    
    
    
    private func setItemList(){
     
        days = ["일","월","화","수","목","금","토"]
        
        let milk = ItemInformation(itemImg: "dataIcMilk", itemName: "우유", itemAlarmCount: 4.0, dataPoints: days, values: uniteSold)
            
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
    
        if indexPath.row == 0 {
            
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "headerCell",for: indexPath) as? IvTVHeaderCell else {return UITableViewCell()}
            cell2.ivItemTVheaderLabel.textColor = .noname
            
            return cell2
        }
            
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemDataCell", for:indexPath) as? IvGraphTVCell else {return UITableViewCell()}
            cell.removeLimitLine()
            cell.setIvGraphTV(itemImage: itemList[indexPath.row - 1].itemImg!, itemName: itemList[indexPath.row - 1].itemName!, itemCount: itemList[indexPath.row - 1].itemAlarmCount!, dataPoints: itemList[indexPath.row - 1].dataPoints!, values: itemList[indexPath.row - 1].values!)
                  
            return cell
        }
      }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        //기기 사이즈 맞춰서 142 생각하기
        
        if indexPath.row == 0 {
           return 60
        }
        else {
            return 142
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier:
            "IvDetailGraphVC") as? IvDetailGraphVC else { return }
      
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        //이 때, "현재 기준"으로 indexPath.row에 해당하는 데이터를 받아와야함
        
        detailViewController.itemName = self.itemList[indexPath.row - 1].itemName
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? IvGraphTVCell else { return }
        cell.removeLimitLine()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

