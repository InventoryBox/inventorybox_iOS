//
//  HomeNewTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/08/21.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeNewCVCell: UICollectionViewCell {
    
    @IBOutlet weak var viewRadious: UIView!
    
    let identifier : String = "HomeNewCVCell"
    
    @IBOutlet var leftStackImage: [UIImageView]! // left image stackview
    @IBOutlet var leftStackview: [UILabel]! // left label stackview
  
    var names : String?
    var bountys : Int?
    
    override func awakeFromNib() {
        makeShadowUnderView()
        
        
    }
    
//    // 왼쪽 관련 Staack
//    func leftSet(image: [String], name: [String]){
//        let setimage : [String] = image
//        let setname : [String] = name
//        
//        if setimage == image || setname == name{
//            for i in 0... < image.count{
//                
//            }
//        }
//        
//    }
//    
    
    
    
  // 그림자주는 코드
   private func makeShadowUnderView() {
       
                viewRadious.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                viewRadious.layer.shadowOpacity = 0.1
                viewRadious.layer.shadowRadius = 8// 퍼지는 정도
                viewRadious.layer.cornerRadius = 10
   }

}

