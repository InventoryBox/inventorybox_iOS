//
//  IvExchangeFavoriteCVCell.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit



class IvExchangeFavoriteCVCell: UICollectionViewCell {
    
    static let identifier: String = "IvExchangeFavoriteCVCell"
    

    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var ivImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var ivPriceLabel: UILabel!
    @IBOutlet weak var ivNameLabel: UILabel!
    @IBOutlet weak var ivLifeLabel: UILabel!
    @IBOutlet weak var ivDateLabel: UILabel!
    
    var delegate: ExchangeButtonDelegate?
    var isColor: UIColor?
    var indexPath: Int?
    var idx: Int?
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
        self.contentView.layer.cornerRadius = 9
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.22
        self.layer.masksToBounds = false
        
    }
    
    private func setImageView() {
        ivImageView.layer.cornerRadius = 9
    }
    
    // set 함수
    func set(_ allExchangeInformation: IvExchangeFavoriteInformation) {
//        let url = URL(string: allExchangeInformation.productImg)
//        self.ivImageView.kf.setImage(with: url)
        ivImageView.image = UIImage(named: allExchangeInformation.productImg)
        if allExchangeInformation.likes == 1 {
            isHeartSwitch = true
        } else {
            isHeartSwitch = false
        }
        
        ivPriceLabel.text = "\(allExchangeInformation.price)"
        ivNameLabel.text = allExchangeInformation.productName
        ivLifeLabel.text = allExchangeInformation.expDate
        ivDateLabel.text = allExchangeInformation.uploadDate
        idx = allExchangeInformation.postIdx
     
        
    
 
    }
    
    // 하트 이미지 Click시 이미지 전환 코드
    @IBAction func switchLikes(_ sender: Any) {
        if isHeartSwitch {
            isHeartSwitch = false
        } else {
            isHeartSwitch = true
        }
        delegate?.didSelectHeart(isClicked: isHeartSwitch, indexPath: indexPath!)
        // 서버 통신
    }
    
    // collectionview Cell 눌렀을 때 세부사항
    @IBAction func selectProduct(_ sender: UIButton) {
        delegate?.whichProductIsSelect(indexPath: indexPath!, idx: idx!)
    }
    
    
}
