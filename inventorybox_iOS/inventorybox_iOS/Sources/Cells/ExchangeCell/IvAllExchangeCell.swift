//
//  IvAllExchangeCell.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/10.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

protocol ExchangeButtonDelegate {
    func whichProductIsSelect(indexPath: Int)
    
    func didSelectHeart(isClicked: Bool, indexPath: Int)
}

extension ExchangeButtonDelegate {
    func whichProductIsSelect(indexPath: Int) {}
    func didSelectHeart(indexPath: Int) {}
}
class IvAllExchangeCell: UICollectionViewCell {
    static let identifier: String = "IvAllExchangeCell"
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var ivImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var ivPriceLabel: UILabel!
    @IBOutlet weak var ivDistanceLabel: UILabel!
    @IBOutlet weak var ivNameLabel: UILabel!
    @IBOutlet weak var ivLifeLabel: UILabel!
    @IBOutlet weak var ivDateLabel: UILabel!
    
    var delegate: ExchangeButtonDelegate?
    var indexPath: Int?
    var isHeartSwitch: Bool = false {
        didSet {
            if isHeartSwitch {
                heartImageView.image = UIImage(named: "exchangemainBtnHeart1")
            } else {
                heartImageView.image = UIImage(named: "exchangemainBtnHeart2")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setRoundView()
        setImageView()
    }
    
    private func setRoundView () {
        self.layer.cornerRadius = 9
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.22
        self.layer.masksToBounds = false
        
    }
    
    private func setImageView() {
        ivImageView.layer.cornerRadius = 9
    }
    
    func set(_ allExchangeInformation: AllExchangeInformation) {
        
        ivImageView.image = UIImage(named: allExchangeInformation.ivImageName)
        isHeartSwitch = allExchangeInformation.ivHeart
        ivPriceLabel.text = allExchangeInformation.ivPrice
        ivDistanceLabel.text = allExchangeInformation.ivDistance
        ivNameLabel.text = allExchangeInformation.ivName
        ivLifeLabel.text = allExchangeInformation.ivLife
        ivDateLabel.text = allExchangeInformation.ivDate

    }
    @IBAction func switchLikes(_ sender: Any) {
        if isHeartSwitch {
            isHeartSwitch = false
        } else {
            isHeartSwitch = true
        }
        delegate?.didSelectHeart(isClicked: isHeartSwitch, indexPath: indexPath!)
        // 서버 통신
    }
    
    @IBAction func selectProduct(_ sender: UIButton) {
        delegate?.whichProductIsSelect(indexPath: indexPath!)
    }
    
}