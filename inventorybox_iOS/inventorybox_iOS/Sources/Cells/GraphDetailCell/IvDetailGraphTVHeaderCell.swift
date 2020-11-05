//
//  IvDetailGraphTVHeaderCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let clickWeek = NSNotification.Name("clickWeek")
}

class IvDetailGraphTVHeaderCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var thisMonthWeekInfoCV: UICollectionView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    var itemGraphData:[GraphInfo] = []
    var weekBtnArray:[String] = []
    var getWeekCount:Int = 0
    var graphCount:Int = 0
    var weekBtnText:String?
    let date = Date()
    let calendar = Calendar.current
    var collectionArray:[WeekInformation] = []
    var weekArray:[SingleGraphWeekInfo] = []
    var itemIdx:Int = 0
    //버튼의 진짜 초기값. 이 상태대로 첫 noti가 실행됨. Noti 실행-> tableviewcell 바뀜
    // var weekBtnIsSelectedStatus:Bool = true
   
    
    override func awakeFromNib() {
        self.thisMonthWeekInfoCV.reloadData()
        
        thisMonthWeekInfoCV.delegate = self
        thisMonthWeekInfoCV.dataSource = self
        
        var month = calendar.component(.month, from: date)
        var thisYear = calendar.component(.year, from: date)
        
        let dateComponents = DateComponents.init(year: thisYear, month: month)
        let monthCurrentDayFirst = Calendar.current.date(from: dateComponents)!
        let monthNextDayFirst = Calendar.current.date(byAdding: .month, value: 1, to: monthCurrentDayFirst)!
        let monthCurrentDayLast = Calendar.current.date(byAdding: .day, value: -1, to: monthNextDayFirst)!
        
        let numberOfWeeks = Calendar.current.component(.weekOfMonth, from: monthCurrentDayLast)
        
        
        for i in 0...numberOfWeeks - 1 {
            
            print("안녕안녕",i)
            print("여긴테이블뷰",numberOfWeeks)
            
            if i == 0 {
                self.weekBtnText = "첫째주"
            } else if i == 1 {
                self.weekBtnText = "둘째주"
            } else if i == 2 {
                self.weekBtnText = "셋째주"
            } else if i == 3 {
                self.weekBtnText = "넷째주"
            } else if i == 4 {
                self.weekBtnText = "다섯째주"
            } else if i == 5 {
                self.weekBtnText = "여섯째주"
            } else {
                self.weekBtnText = "일곱째주"
            }
            
            if self.graphCount < numberOfWeeks {
                self.collectionArray.append(WeekInformation(btnText: self.weekBtnText!, btnIsSelected: true))
                
                self.graphCount += 1
            }
        }
        
        print(numberOfWeeks)
        print(collectionArray)
        print("여기 실행 됩니까")
        
        NotificationCenter.default.addObserver(self, selector: #selector(setStatus(_:)), name: .clickWeek, object: nil)
    }
    
    override func prepareForReuse(){
        self.thisMonthWeekInfoCV.reloadData()

        thisMonthWeekInfoCV.delegate = self
        thisMonthWeekInfoCV.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(setStatus(_:)), name: .clickWeek, object: nil)
    }

    
    @objc func setStatus(_ notification: NSNotification) {
        guard let row = notification.userInfo?["week"] as? Int else { return }
        var status = notification.userInfo?["status"] as? Bool
        
        print("setStatusFromNoti")
        
        if status == true {
            collectionArray[row].btnIsSelected = status!
            print(collectionArray)
        }
        else {
            collectionArray[row].btnIsSelected = status!
            print(collectionArray)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("firstcount",collectionArray.count)
        return collectionArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekInThisMonthCVCell", for: indexPath) as! WeekInThisMonthCVCell
        cell.weekBtn.setTitle(collectionArray[indexPath.row].btnText, for: .normal)
        cell.weekBtn.layer.cornerRadius = 9
        
        //제일 먼저 실행됨
        cell.status = collectionArray[indexPath.row].btnIsSelected
        print(collectionArray[indexPath.row].btnIsSelected)
        cell.week = indexPath.row
        print(cell.status)
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
