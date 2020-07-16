//
//  HomeTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var graphView: UIView!     // 그래프 나오는View
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 첫 그래프 화면 숨기기
        graphView.isHidden = true
        
        makeShadowUnderView()

    }
    
    
    // checkBox눌렀을 때
    @IBAction func checkBoxPress(_ sender: Any) {
        if checkvalue == false{ // 체크를 처음 눌렀을 때 On
            checkvalue = true
        }else{                  // // 체크를 풀었을 때 Off
            checkvalue = false
        }
        NotificationCenter.default.post(name: .init("tablevalue"), object: nil, userInfo: ["bool": checkvalue, "name": productNameText.text!])
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
    func SetProductImformation(productImage: String, productNameTx: String, productCountTx: Int, productSetTx: String) {

        productImg.image = UIImage(named: productImage)
        productNameText.text = productNameTx
        productCountText.text = String(productCountTx)  // int형으로 받아야 함
        productSetText.text = productNameTx
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

