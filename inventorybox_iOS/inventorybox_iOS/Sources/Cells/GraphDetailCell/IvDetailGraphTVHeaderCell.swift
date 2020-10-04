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
    var weekBtnArray:[String] = []
    
    var weekArray:[WeekInformation] = []
    
    //버튼의 진짜 초기값. 이 상태대로 첫 noti가 실행됨. Noti 실행-> tableviewcell 바뀜
    // var weekBtnIsSelectedStatus:Bool = true
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thisMonthWeekInfoCV.delegate = self
        thisMonthWeekInfoCV.dataSource = self
        
        setWeek()
     //   print(weekArray)
        yearLabel.text = "2020"
        monthLabel.text = "07"
         NotificationCenter.default.addObserver(self, selector: #selector(setStatus(_:)), name: .clickWeek, object: nil)
        
        
    }
    
    func setWeek(){
        let case1 = WeekInformation(btnText:"첫째주", btnIsSelected: true)
        let case2 = WeekInformation(btnText:"둘째주", btnIsSelected: true)
        let case3 = WeekInformation(btnText:"셋째주", btnIsSelected: true)
        let case4 = WeekInformation(btnText:"넷째주", btnIsSelected: true)
        let case5 = WeekInformation(btnText:"다섯째주", btnIsSelected: true)

        weekArray = [case1,case2,case3,case4,case5]
        
    }
    
    @objc func setStatus(_ notification: NSNotification) {
        guard let row = notification.userInfo?["week"] as? Int else { return }
        var status = notification.userInfo?["status"] as? Bool

        print("setStatusFromNoti")

        if status == true {
        weekArray[row].btnIsSelected = status!
            print(weekArray)
        }
        else {
        weekArray[row].btnIsSelected = status!
            print(weekArray)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weekArray.count
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekInThisMonthCVCell", for: indexPath) as! WeekInThisMonthCVCell
        
        cell.weekBtn.setTitle(weekArray[indexPath.row].btnText, for: .normal)
        cell.weekBtn.layer.cornerRadius = 9
        
        //제일 먼저 실행됨
       cell.status = weekArray[indexPath.row].btnIsSelected!
        cell.week = indexPath.row
       print(cell.status)
        return cell

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
