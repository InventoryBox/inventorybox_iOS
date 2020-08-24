//
//  SelectHeaderCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/10.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SelectHeaderCell: UITableViewCell {
    static let identifier: String = "SelectHeaderCell"
    
    var delegate: CellButtonDelegate?
    
    var isClicked: Bool = false {
        didSet {
            
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func allSelectBtnPressed(_ sender: Any) {
        if !isClicked {
            isClicked = true
        } else {
            isClicked = false
        }
        delegate?.didAllBtnClickedCheckButton(isClicked: isClicked)
    }
    
}
