//
//  HomeNewDetailTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeNewDetailTVCell: UITableViewCell {

    @IBOutlet var itemImg: UIImageView!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemMemoCountLabel: UILabel!
    @IBOutlet var itemFlagBtn: UIButton!
    @IBOutlet var homeMoreBtnImg: UIButton!
    @IBOutlet var itemRoundView: UIView!
    @IBOutlet var itemUnitLabel: UILabel!
    var orderCheckInformations:[HomeItem] = []
    var flagInt:[HomeDetailInfoData] = []
    var itemIndex:Int = 0
    var allfalgInt : [Int] = []
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemRoundView.layer.cornerRadius = 10
        itemRoundView.layer.shadowRadius = 10
        itemRoundView.layer.shadowOpacity = 0.1
        
        HomeService.shared.getHome { [self] networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {return }
                self.orderCheckInformations = dt.result
//                print(self.orderCheckInformations)
                
                for i in 0...self.orderCheckInformations.count - 1 {
                    self.flagInt.append(HomeDetailInfoData(open: false, flagInt: orderCheckInformations[i].flag))
                }
                
                for i in 0..<orderCheckInformations.count{
                    allfalgInt.append(flagInt[i].flagInt)
                }
                
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    
    @IBAction func flagBtnTouchUp(_ sender: UIButton) {
       
        if flagInt[cellIndexPath!.section].flagInt == 1{
//            print(flagInt[cellIndexPath!.section].flagInt)
            itemFlagBtn.setImage(UIImage(named: "homeBtnCheckUnselect"), for: .normal)
            flagInt[cellIndexPath!.section].flagInt = 0
        }else {
//            print(flagInt[cellIndexPath!.section].flagInt)
            itemFlagBtn.setImage(UIImage(named: "homeBtnCheckSelect"), for: .normal)
            flagInt[cellIndexPath!.section].flagInt = 1
        }
       
        // 노티피로 눌렸을때 그 위치랑 값 알리기
        NotificationCenter.default.post(name: .init("checkBox"), object: nil, userInfo: ["flagNum": flagInt[cellIndexPath!.section].flagInt, "where": cellIndexPath!.section])
        
        
        
        IvHomeFlagPostService.shared.getHomeFlagPost(itemIdx: itemIndex, flag: flagInt[cellIndexPath!.section].flagInt, completion: { networkResult in
            switch networkResult{
            case .success(let data):
                print(data)
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
            
        })
        print(flagInt)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
