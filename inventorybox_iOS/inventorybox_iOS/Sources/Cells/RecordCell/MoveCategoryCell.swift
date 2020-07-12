//
//  MoveCategoryCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol CategoryButtonDelegate {
    func didSelectCategory(categoryName: String ,indexPath: Int)
    func didDeleteCategoryBtnPrssed(categoryName: String ,indexPath: Int)
}

extension CategoryButtonDelegate {
    func didSelectCategory(categoryName: String ,indexPath: Int) { }
    func didDeleteCategoryBtnPrssed(categoryName: String ,indexPath: Int) {}
}

class MoveCategoryCell: UITableViewCell {
    static let identifier: String = "MoveCategoryCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    
    var delegate: CategoryButtonDelegate?
    var indexpath: Int?
    
    @IBOutlet weak var selectBtn: UIButton!
    
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
        self.roundView.layer.borderColor = UIColor.black.cgColor
//        self.roundView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
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
