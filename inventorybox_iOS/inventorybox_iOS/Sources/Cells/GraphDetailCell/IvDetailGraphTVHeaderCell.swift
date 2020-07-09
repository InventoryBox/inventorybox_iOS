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
        var week:[String] = ["첫째주","둘째주","셋째주","넷째주","다섯째주","여섯째주"]
        
        let case1 = WeekInformation(btnText:"첫째주")
        let case2 = WeekInformation(btnText:"둘째주")
        let case3 = WeekInformation(btnText:"셋째주")
        let case4 = WeekInformation(btnText:"넷째주")
        let case5 = WeekInformation(btnText:"다섯째주")
        let case6 = WeekInformation(btnText:"여섯째주")
        let case7 = WeekInformation(btnText:"일곱째주")
        
        weekArray = [case1,case2,case3,case4,case5,case6,
                     case7]
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekArray.count
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekInThisMonthCVCell", for: indexPath) as! WeekInThisMonthCVCell
        
        cell.weekBtn.titleLabel?.text = weekArray[indexPath.row].btnText
        
        
        return cell

    
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
