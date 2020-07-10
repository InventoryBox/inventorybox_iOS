//
//  IvDetailGraphTVHeaderCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvDetailGraphTVHeaderCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
  
    @IBOutlet var thisMonthWeekInfoCV: UICollectionView!
    
    var weekArray:[WeekInformation] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thisMonthWeekInfoCV.delegate = self
        thisMonthWeekInfoCV.dataSource = self
        
        setWeek()
        print(weekArray)
    }
    
    func setWeek(){
       // var week:[String] = ["첫째주","둘째주","셋째주","넷째주","다섯째주","여섯째주"]
        
        let case1 = WeekInformation(btnText:"1주차")
        let case2 = WeekInformation(btnText:"2주차")
        let case3 = WeekInformation(btnText:"3주차")
        let case4 = WeekInformation(btnText:"4주차")
        let case5 = WeekInformation(btnText:"5주차")
        let case6 = WeekInformation(btnText:"6주차")
        let case7 = WeekInformation(btnText:"7주차")
        
        weekArray = [case1,case2,case3,case4,case5,case6,
                     case7]
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekArray.count
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekInThisMonthCVCell", for: indexPath) as! WeekInThisMonthCVCell
        
        cell.setWeekInfo(monthOfWeek: weekArray[indexPath.row].btnText!)
     
        print(weekArray)
        return cell

    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
