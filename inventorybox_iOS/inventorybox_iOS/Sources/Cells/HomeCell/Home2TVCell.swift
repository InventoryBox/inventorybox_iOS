//
//  HomeTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox

class Home2TVCell: UITableViewCell {

    static let identifier : String = "Home2TVCell"
    var checkvalue : Bool = false   // checkbox
    var moreValue : Bool = false    // 더보기 버튼
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var moreBtn: UIButton!           // 더보기 버튼
    @IBOutlet weak var productImg: UIImageView!     // 제품 이미지
    @IBOutlet weak var productNameText: UILabel!    // 제품 이름
    @IBOutlet weak var productCountText: UILabel!   // 제품 개수
    @IBOutlet weak var productSetText: UILabel!     // 제품 묶음
    @IBOutlet weak var graphView: UIView!           // 그래프 나오는View
    @IBOutlet weak var checkBoxBtn: BEMCheckBox!
    
    var itemIdx: Int?
    var indexPath: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 첫 그래프 화면 숨기기
        graphView.isHidden = true
        
        
        makeShadowUnderView()
    }
     
    
    // checkBox눌렀을 때
    @IBAction func checkBoxPress(_ sender: Any) {
        if checkBoxBtn.on == false{ // 체크를 처음 눌렀을 때 On
            checkvalue = true
            
        }else{                  // // 체크를 풀었을 때 Off
            checkvalue = false
        }
        
        var isSelect: Int = 0
        if checkvalue {
            isSelect = 0
        } else {
            isSelect = 1
        }
        
        NotificationCenter.default.post(name: .init("tablevalue"), object: nil, userInfo: ["bool": checkBoxBtn.on, "name": productNameText.text!, "indexPath": indexPath!, "isSelect": isSelect])
        
        IvHomeFlagPostService.shared.getRecordEditIvPost(itemIdx: itemIdx!, flag: isSelect) { networkResult in
            switch networkResult {
            case .success(let data):
                
                print(data)
                
            case .requestErr(let msg):
                print(msg)
            case .pathErr:
                print("path")
                break
            case .serverErr:
                print("server")
                break
            case .networkFail:
                print("network")
                break
            }
        }
        
    }
    
    
    
    // 자세히 눌렀을 떄
    @IBAction func MorPressBtn(_ sender: Any) {
        if moreValue == false{  // 자세히 버튼 처음 눌렀을 떄
            graphView.isHidden = false
            moreBtn.setImage(UIImage(named: "homeBtnDetail02.png"), for: .normal)
            moreValue = true
        }else{
            moreBtn.setImage(UIImage(named: "homeBtnDetail01.png"), for: .normal)
            graphView.isHidden = true
            moreValue = false
        }
        NotificationCenter.default.post(name: .init("morepressbutton"), object: nil, userInfo: ["bool": moreValue, "name": productNameText.text!])
    }
   
    
    // Set 부분
    func SetProductImformation(productImage: String, productNameTx: String, productCountTx: Int, productSetTx: String, checkFlag: Int) {
        
        // URL을 이미지로 변환 시키기
        let url = URL(string: productImage)
        let data = try? Data(contentsOf: url!)
        productImg.image = UIImage(data: data!)
        
        productNameText.text = productNameTx
        productCountText.text = String(productCountTx)  // int형으로 받아야 함
        productSetText.text = productSetTx
        
        // 0,1로 들어오는 값을 true, false 값으로 바꾸기
        if checkFlag == 0 {
            checkvalue = false
        } else {
            checkvalue = true
        }
        checkBoxBtn.on = checkvalue

    }
    
    
    private func makeShadowUnderView() {
        // 그림자주는 코드
        roundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        roundView.layer.shadowOpacity = 0.1
        roundView.layer.shadowRadius = 8// 퍼지는 정도
        
        roundView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}

