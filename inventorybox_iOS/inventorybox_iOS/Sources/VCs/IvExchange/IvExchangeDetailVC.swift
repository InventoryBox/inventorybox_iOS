//
//  IvExchangeDetailVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvExchangeDetailVC: UIViewController {
    
    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var inventoryExchangeCategoryLabel: UILabel!
    @IBOutlet weak var articleWrittenDateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UIButton!
    @IBOutlet weak var inventoryImageView: UIImageView!
    
    @IBOutlet weak var inventoryInfoLabel: UILabel!
    @IBOutlet weak var inventoryPriceInfoLabel: UILabel!
    @IBOutlet weak var inventoryPriceLabel: UILabel!
    @IBOutlet weak var inventoryListPriceInfo: UILabel!
    @IBOutlet weak var inventoryListPriceLabel: UILabel!
    @IBOutlet weak var inventoryCountToSellInfo: UILabel!
    @IBOutlet weak var inventoryCountToSellLabel: UILabel!
    @IBOutlet weak var inventoryLifeInfo: UILabel!
    @IBOutlet weak var inventoryLifeLabel: UILabel!
    @IBOutlet weak var inventoryDetailInfo: UILabel!
    @IBOutlet weak var inventoryDetailLabel: UITextView!
    
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeLocationLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var phoneBtnLabel: UILabel!
    @IBOutlet weak var likeButtonLabel: UILabel!
    
    let sellerPhoneNumber: String? = "01073453436"
    var isLiked: Bool = false {
        didSet {
            if isLiked {
                likeButtonLabel.text = "좋아요 ❤️"
            } else {
                likeButtonLabel.text = "좋아요 🤍"
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelCustom()
        setShadow()
    }
    
    private func setShadow() {
        topView.layer.shadowOpacity = 0.1
        topView.layer.shadowRadius = 2
        topView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    private func setLabelCustom() {
        inventoryNameLabel.font = UIFont(name: "NanumSquareEB", size: 16)
        inventoryNameLabel.textColor = UIColor.greyishBrown
        inventoryExchangeCategoryLabel.font = UIFont(name: "NanumSquareB", size: 12)
        inventoryExchangeCategoryLabel.textColor = UIColor.brownGrey
        inventoryLifeLabel.font = UIFont(name: "NanumSquareB", size: 12)
        inventoryLifeLabel.textColor = UIColor.brownGrey
        distanceLabel.layer.cornerRadius = 12
        
        distanceLabel.titleLabel?.textColor = .white
        distanceLabel.titleLabel?.font = UIFont(name: "NanumSquareB", size: 13)
        distanceLabel.backgroundColor = .yellow
    
        inventoryInfoLabel.font = UIFont(name: "NanumSquareEB", size: 14)
        inventoryPriceLabel.font = UIFont(name: "NanumSquareEB", size: 22)
        inventoryListPriceInfo.font = UIFont(name: "NanumSquareB", size: 12)
        inventoryListPriceLabel.font = UIFont(name: "NanumSquareB", size: 12)
        inventoryCountToSellInfo.font = UIFont(name: "NanumSquareEB", size: 12)
        inventoryDetailInfo.font = UIFont(name: "NanumSquareEB", size: 12)
        inventoryCountToSellLabel.font = UIFont(name: "NanumSquareB", size: 14)
        inventoryLifeLabel.font = UIFont(name: "NanumSquareB", size: 14)
        
        inventoryDetailLabel.font = UIFont(name: "NanumSquareR", size: 13)
        
        sellerNameLabel.font = UIFont(name: "NanumSquareB", size: 14)
        storeNameLabel.font = UIFont(name: "NanumSquareB", size: 14)
        storeLocationLabel.font = UIFont(name: "NanumSquareB", size: 14)
        likeButtonLabel.font = UIFont(name: "NanumSquareB", size: 16)
        phoneBtnLabel.font = UIFont(name: "NanumSquareB", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
    }

    
    @IBAction func likeBtnPressed(_ sender: Any) {
        if isLiked {
            isLiked = false
        } else {
            isLiked = true
        }
        
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {
        let phoneNumber = sellerPhoneNumber ?? ""
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
