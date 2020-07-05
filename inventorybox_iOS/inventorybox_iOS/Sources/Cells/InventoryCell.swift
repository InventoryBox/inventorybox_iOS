//
//  InventoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {
    
    static let identifier: String = "InventoryCell"
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var inventoryImageView: UIImageView!
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var minimumInventoryCountLabel: UILabel!
    @IBOutlet weak var orderInventoryCountLabel: UILabel!
    @IBOutlet weak var inventoryCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        roundView.layer.cornerRadius = 9
        
        minimumInventoryCountLabel.textColor = UIColor.brownGrey
        
        orderInventoryCountLabel.textColor = UIColor.brownGrey
        
        inventoryCountLabel.textColor = UIColor.brownGrey
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    func setInventoryData(_ inventoryImageName: String, _ inventoryName: String, _ minimumInventoryCount: String, _ orderInventoryCount: String, _ inventoryCount: String) {
        inventoryImageView.image = UIImage(named: inventoryImageName)
        inventoryNameLabel.text = inventoryName
        minimumInventoryCountLabel.text = minimumInventoryCount
        orderInventoryCountLabel.text = orderInventoryCount
        inventoryCountLabel.text = inventoryCount
    }

}
