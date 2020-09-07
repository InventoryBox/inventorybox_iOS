//
//  HeaderCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class AddIvHeaderCell: UITableViewCell {
    static let identifier: String = "AddIvHeaderCell"
    
    @IBOutlet weak var addIvBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
