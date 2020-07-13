//
//  SearchResultCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol AddressClickDelegate {
    func setAddress(addressName: String)
}

class SearchResultCell: UITableViewCell {
    static let identifier: String = "SearchResultCell"
    @IBOutlet weak var addressLabel: UILabel!
    
    var delegate: AddressClickDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ data: String ) {
        addressLabel.text = data
    }
    
    @IBAction func addressBtnPressed(_ sender: Any) {
        guard let name = addressLabel.text else { return }
        delegate?.setAddress(addressName: name)
//        print("tap")
    }
    
}
