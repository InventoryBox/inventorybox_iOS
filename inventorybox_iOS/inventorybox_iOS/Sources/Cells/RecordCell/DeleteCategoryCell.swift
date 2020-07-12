//
//  DeleteCategoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class DeleteCategoryCell: UITableViewCell {
    static let identifier: String = "DeleteCategoryCell"
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var delegate: CategoryButtonDelegate?
    var indexpath: Int?
    
    var isWhole: Bool = false {
        didSet {
            if isWhole {
                roundView.backgroundColor = .veryLightPinkTwo
                deleteBtn.isHidden = true
                
            } else {
                roundView.backgroundColor = .white
                deleteBtn.isHidden = false
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setViewBorder()
        
    }
    
    private func setViewBorder() {
        self.roundView.layer.borderWidth = 1
        self.roundView.layer.borderColor = UIColor.black.cgColor
        //        self.roundView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
    
    func setCellInformation(categoryInfo: String) {
        
        categoryLabel.text = categoryInfo
        
    }
    @IBAction func deleteCategoryBtn(_ sender: Any) {
        guard let name = categoryLabel.text else { return }
        delegate?.didDeleteCategoryBtnPrssed(categoryName: name, indexPath: indexpath!)
    }
}
