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
    @IBOutlet var homeMoreBtnImg: UIImageView!
    @IBOutlet var itemRoundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemRoundView.layer.cornerRadius = 10
        itemRoundView.layer.shadowRadius = 10
        itemRoundView.layer.shadowOpacity = 0.1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
