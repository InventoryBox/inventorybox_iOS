//
//  WeekInThisMonthCVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class WeekInThisMonthCVCell: UICollectionViewCell {
    
    @IBOutlet var weekBtn: UIButton!
    
    
    func setWeekInfo(monthOfWeek:String){
        weekBtn.titleLabel?.text = monthOfWeek
       
    }
        
        
}
