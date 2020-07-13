//
//  SelectCategoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SelectCategoryCell: UITableViewCell {
    static let identifier: String = "SelectCategoryCell"
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    var delegate: CategoryButtonDelegate?
    var indexpath: Int?
    
    var isWhole: Bool = false {
        didSet {
            if isWhole {
                roundView.backgroundColor = .veryLightPinkTwo
                selectBtn.isEnabled = false
            } else {
                roundView.backgroundColor = .white
                selectBtn.isEnabled = true
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewBorder()
    }
    private func setViewBorder() {
        self.roundView.layer.borderWidth = 1
        self.roundView.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        self.roundView.layer.cornerRadius = 8
    }
    
    func setCellInformation(categoryInfo: String) {
        
        categoryLabel.text = categoryInfo
        
    }
    
    @IBAction func categorySelected(_ sender: Any) {
        guard let name = categoryLabel.text else { return }
        delegate?.didSelectCategory(categoryName: name, indexPath: indexpath!)
        //        print("tap")
    }
}
