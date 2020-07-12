//
//  MoveCategoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol CategoryButtonDelegate {
    func didSelectCategory(indexPath: Int)
}
class MoveCategoryCell: UITableViewCell {
    static let identifier: String = "MoveCategoryCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    
    var delegate: CategoryButtonDelegate?
    var indexpath: Int?
    var isWhole: Bool = false {
        didSet {
            roundView.backgroundColor = .gray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setViewBorder()
        
    }
    
    private func setViewBorder() {
        self.roundView.layer.borderWidth = 1
        self.roundView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellInformation(categoryInfo: String) {
        
        categoryLabel.text = categoryInfo
        
    }
    
    @IBAction func categorySelected(_ sender: Any) {
        delegate?.didSelectCategory(indexPath: indexpath!)
    }
    
}
