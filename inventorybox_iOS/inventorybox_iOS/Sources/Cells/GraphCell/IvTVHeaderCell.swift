//
//  IvTVHeaderCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvTVHeaderCell: UITableViewCell {

    @IBOutlet var ivItemTVheaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivItemTVheaderLabel.text = "※ 하단 그래프의 노란색 가로선은 '발주 알림 개수'를 표시한 것이며, \n 노란색 막대 그래프의 간격을 통해 '발주일 간격 파악'이 용이합니다."
        ivItemTVheaderLabel.sizeToFit()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
