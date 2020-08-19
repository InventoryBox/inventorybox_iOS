//
//  MemoTVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class MemoTVCell: UITableViewCell {

    static let identifier : String = "MemoTVCell"
    var checkvalue : Bool = false   // checkbox
    var moreValue : Bool = false    // 더보기 버튼
    var textcount : Int?
    @IBOutlet weak var moreBtn: UIButton!
    
    var count : Int? // Textfield 관련
    var idx: Int?
    
    @IBOutlet weak var productImg: UIImageView!            // 우유
    @IBOutlet weak var productNameText: UILabel!           // 이름
    @IBOutlet weak var productCountText: UITextField!      // textfiled
    @IBOutlet weak var shadowview: UIView!                 // 그림자 주는 view
    @IBOutlet weak var graphView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        graphView.isHidden = true
        // Initialization code
        addDoneButtonOnKeyboard()
        makeShadowUnderView()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // 그림자주는 코드
    private func makeShadowUnderView() {
        shadowview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowview.layer.shadowOpacity = 0.1
        shadowview.layer.shadowRadius = 8       // 퍼지는 정도
        shadowview.layer.cornerRadius = 10
    }
    
    
    func SetMemoProductImformation(productImage: String, productNameTx: String, productCountTx: Int) {
        
        // URL을 이미지로 변환 시키기
        let url = URL(string: productImage)
        let data = try? Data(contentsOf: url!)
        
        productImg.image = UIImage(data: data!)
        productNameText.text = productNameTx
        productCountText.text = String(productCountTx)  // int형으로 받아야 함
    }
    
    @IBAction func memoMorePressBtn(_ sender: Any) {
        if moreValue == false{  // 자세히 버튼 처음 눌렀을 떄
            graphView.isHidden = false
            moreBtn.setImage(UIImage(named: "homeBtnDetail02.png"), for: .normal)
            moreValue = true
        }else{
            moreBtn.setImage(UIImage(named: "homeBtnDetail01.png"), for: .normal)
            graphView.isHidden = true
            moreValue = false
        }
        
        NotificationCenter.default.post(name: .init("memotablevalue"), object: nil, userInfo: ["bool": moreValue, "name": productNameText.text!])
    }
  
    
    // Minus Button 눌렀을 때
    @IBAction func minusBtnPress(_ sender: Any) {
        count = Int(productCountText.text!)
        if count! > 0 {
            count = count! - 1
            productCountText.text = String(count!)
        }else{
            productCountText.text = String(0)
        }
    }
    
    
    // Plus Button 눌렀을 때
    @IBAction func plussBtnPress(_ sender: Any) {
         count = Int(productCountText.text!)
        if count! < 10000 {
            count = count! + 1
            productCountText.text = String(count!)
        }
    }
    
    
    // MARK: Number Keypad에 Done Button 넣기
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        productCountText.inputAccessoryView = doneToolbar
    }
    
    // Done Button 눌렀을 때
    @objc func doneButtonAction(){
        // 노티피 주기위 위해
        let textcount: Int = Int(productCountText.text!)!
//        print("\(textcount!) 값을 보내겠습니다")
        NotificationCenter.default.post(name: .init("textmodify"), object: nil, userInfo: ["count": textcount, "name": productNameText.text!, "idx": idx!])
//
        productCountText.resignFirstResponder()
    }
}
