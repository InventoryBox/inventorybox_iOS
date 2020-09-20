//
//  SettingCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/09/20.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    static let identifier: String = "SettingCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(title: String) {
        titleLabel.text = title
    }

}
