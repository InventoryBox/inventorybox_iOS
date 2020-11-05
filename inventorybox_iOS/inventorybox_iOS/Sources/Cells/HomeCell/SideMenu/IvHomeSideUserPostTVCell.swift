//
//  IvHomeSideUserPostTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Kingfisher

class IvHomeSideUserPostTVCell: UITableViewCell {
    
    static let identifier : String = "IvHomeSideUserPostTVCell"
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var stuffUpload: UILabel!
    @IBOutlet weak var stuffImage: UIImageView!
    @IBOutlet weak var stuffName: UILabel!
    @IBOutlet weak var stuffExep: UILabel!
    @IBOutlet weak var stuffPrice: UILabel!
    var isSolded : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeShadowUnderViedw()
    }
    
    
    // 그림자주는 코드
    private func makeShadowUnderViedw(){
        viewBackground.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBackground.layer.shadowOpacity = 0.1
        viewBackground.layer.shadowRadius = 8
        viewBackground.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: setInformation
    func setInformation(upload: String, imageName: String, Name: String, exep: String, sold: Int , Price: Int){
        
        stuffUpload.text = "\(date(upload))"            // 올린 날짜
        let url = URL(string: imageName)
        self.stuffImage.kf.setImage(with: url)
        stuffName.text = Name                           // 물건 이름
        stuffExep.text = exep                           // 유통기한
        isSolded = sold                                 // 팔렸는지 안팔렸는지
        stuffPrice.text = "\(Price)"                    // 가격
    }
    
    
    // String으로 받아온 날짜 값을 Date로 변환시켜서 원하는 값만 빼기~
    func date(_ day: String) ->  String{
        
        // UploadDate String -> Date 값으로 변환하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "BST") as TimeZone?
        let date : Date = dateFormatter.date(from: day)!
        
        
        // Date값에서 날짜만 받기
        let year_Month_day = DateFormatter()
        year_Month_day.dateFormat = "yyyy-MM-dd"
        let calender = year_Month_day.string(from: date)
        
        // Date값에서 시간만 받기
        let Hour_Minute_seconde = DateFormatter()
        Hour_Minute_seconde.dateFormat = "HH:mm:ss"
        let Time = Hour_Minute_seconde.string(from: date)
        
        return calender
    }
}





