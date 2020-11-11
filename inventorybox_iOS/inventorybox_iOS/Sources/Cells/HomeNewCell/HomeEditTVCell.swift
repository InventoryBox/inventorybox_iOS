//
//  HomeEditTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeEditTVCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemCountTextField: UITextField!
    @IBOutlet var showMoreImg: UIImageView!
    @IBOutlet var itemRoundView: UIView!
    @IBOutlet var minusBtn: UIButton!
    @IBOutlet var plusBtn: UIButton!
    var minusInt : Int = 0
    var plusInt : Int = 0
    var finalMinusInt : Int = 0
    var finalPlusInt : Int = 0
    var orderCheckInformations : [HomeItem] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemRoundView.layer.cornerRadius = 10
        itemRoundView.layer.shadowRadius = 10
        itemRoundView.layer.shadowOpacity = 0.1
    }
    


    @IBAction func clickMinusBtn(_ sender: UIButton) {
        minusInt = (itemCountTextField.text?.toInt()!)!
        minusInt = minusInt - 1
        itemCountTextField.text = String(minusInt)
        finalMinusInt = minusInt
        
        self.orderCheckInformations[cellIndexPath!.section].memoCnt = finalMinusInt
        
        HomeMemoModifyPostService.shared.getHomeMemoAuthPost(data: orderCheckInformations, completion: { networkResult in
            switch networkResult{
            case .success(let data): print(data)
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
        
        
        HomeService.shared.getHome { [self] networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    
                    return }
                self.orderCheckInformations = dt.result
                print(self.orderCheckInformations.count)
            
                
                DispatchQueue.main.async {
                    print("잘오냐",self.orderCheckInformations)
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
        

    
    @IBAction func clickPlusBtn(_ sender: UIButton) {
        plusInt = (itemCountTextField.text?.toInt()!)!
        plusInt = plusInt + 1
        itemCountTextField.text = String(plusInt)
        finalPlusInt = plusInt
        
        self.orderCheckInformations[cellIndexPath!.section].memoCnt = finalPlusInt
        
        HomeMemoModifyPostService.shared.getHomeMemoAuthPost(data: orderCheckInformations, completion: { networkResult in
            switch networkResult{
            case .success(let data): print(data)
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
        
        HomeService.shared.getHome { [self] networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    
                    return }
                self.orderCheckInformations = dt.result
                print(self.orderCheckInformations.count)
               
                    print("잘오냐",self.orderCheckInformations)
                
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension String {
        //Converts String to Int
        public func toInt() -> Int? {
            if let num = NumberFormatter().number(from: self) {
                return num.intValue
            } else {
                return nil
            }
        }
}


extension UITableViewCell {
    var tableView: UITableView? {
    
        return (self.next as! UITableView)
    }

    var cellIndexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
