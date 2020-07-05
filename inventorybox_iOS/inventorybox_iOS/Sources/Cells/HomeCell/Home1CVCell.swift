//
//  Home1VCCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class Home1CVCell: UICollectionViewCell {

    
    @IBOutlet weak var profileBtn: UIButton!        // 프로필 버튼
    @IBOutlet weak var dayText: UILabel!            // 요일
    @IBOutlet weak var yearmonthText: UILabel!      // @@@@년 @@월
    @IBOutlet weak var dayofweekText: UILabel!      // 몇 일
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
