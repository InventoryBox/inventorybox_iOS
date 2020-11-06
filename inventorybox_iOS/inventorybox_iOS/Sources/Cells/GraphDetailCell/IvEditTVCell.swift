//
//  IvEditTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit


class IvEditTVCell: UITableViewCell {
    
    var delegate: UIViewController?
    var alert:UIAlertController!
    var itemIdx:Int?

    @IBOutlet var alarmCntTextField: UITextField!
    @IBOutlet var memoCntTextField: UITextField!
    @IBOutlet var alarmUnitLabel: UILabel!
    @IBOutlet var memoUnitLabel: UILabel!
    var alarmCnt:Int?
    var memoCnt:Int?
    
    
    override func prepareForReuse() {
        alarmCntTextField.text = "\(alarmCnt)"
        memoCntTextField.text = "\(memoCnt)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func memoPost(_ sender: UIButton) {
        
        alarmCnt = alarmCntTextField.text?.toInt()
        memoCnt = memoCntTextField.text?.toInt()
        
        
        //옵셔널 해결하기
        
        IvGraphMemoModifyService.shared.postGraphModify(itemIdx: itemIdx!, alarmCnt: alarmCnt!, memoCnt: memoCnt!, completion: { networkResult in
            switch networkResult{
            case .success(let data):
                print(data)
                
                self.showAlert()
              
           
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
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "메모수정", message: "성공", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        delegate!.present(alert, animated: true, completion: nil)
    }
    
    
    
}
