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
    @IBOutlet var weekLabel: UILabel!
    
    //버튼을 클릭했을 때 몆주차에 해당하는 버튼인지 저장하는 변수
     var clickWeekInfo:String = ""
    
    override func awakeFromNib() {
        weekBtn.layer.cornerRadius = 12
    }
    
    func setWeekInfo(monthOfWeek:String){
        
        
        weekBtn.titleLabel?.text = monthOfWeek
        weekLabel.text = monthOfWeek
        weekBtn.layer.cornerRadius = 12
        weekBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        weekBtn.layer.shadowOpacity = 0.1
        weekBtn.layer.borderWidth = 0.1
        
    }
        
    @IBAction func clickWeekInfo(_ sender: UIButton) {
        
        //Sender를 이용해서 얻은 값을 전역변수에 저장한 뒤
        //tableViewCell에서 데이터로 사용하려 한다.
        
        var isClicked:Bool = self.weekBtn.isSelected
        print(isSelected)
        
        clickWeekInfo = (sender.titleLabel?.text)!
        print(clickWeekInfo)
        
        if sender.titleLabel?.text == "1주차" {
            
        }
      
        
        if isSelected == false {
            self.weekBtn.backgroundColor = .yellow
        }
        else {
            self.weekBtn.backgroundColor = .white
        }
        
    }
  
    
}
