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
    
    var count : String? // Textfield 관련
    
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameText: UILabel!
    @IBOutlet weak var productCountText: UITextField!   // textfiled
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addDoneButtonOnKeyboard()        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func SetMemoProductImformation(productImage: String, productNameTx: String, productCountTx: String) {

        productImg.image = UIImage(named: productImage)
        productNameText.text = productNameTx
        productCountText.text = productCountTx  // int형으로 받아야 함
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
    
    @objc func doneButtonAction(){
        productCountText.resignFirstResponder()
    }
}
