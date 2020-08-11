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
    
    @IBOutlet weak var distanceLab: UILabel!
    
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
    
    var idx: Int?
    
    var sellerPhoneNumber: String? = ""
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
        getDataFromServer()
        
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
    private func getDataFromServer() {
        
        IvExchangeDetailService.shared.getExchangeDetail(idx: idx!) { (networkResult) in
            switch networkResult {
            case .success(let data):
                
                guard let dt = data as? IvExchangeDetailClass else { return }

                self.inventoryNameLabel.text = dt.itemInfo.productName
                if dt.itemInfo.isFood == 0 {
                    self.inventoryExchangeCategoryLabel.text = "공산품"
                } else {
                    self.inventoryExchangeCategoryLabel.text = "식품"
                }
                self.articleWrittenDateLabel.text = dt.itemInfo.uploadDate
                print("\(dt.itemInfo.distDiff)" + "m")
                if dt.itemInfo.distDiff > 1000 {
                    self.distanceLabel.titleLabel?.text = "\(dt.itemInfo.distDiff / 1000)" + "km"
                    self.distanceLab.text = "\(dt.itemInfo.distDiff / 1000)km"
                    self.distanceLabel.backgroundColor = UIColor.gray
                    self.distanceLab.textColor = .white
                } else {
                    self.distanceLabel.titleLabel?.text = "\(dt.itemInfo.distDiff)m"
                    self.distanceLabel.backgroundColor = UIColor.yellow
                    self.distanceLab.text = "\(dt.itemInfo.distDiff)m"
                    self.distanceLab.textColor = .white
                }
                if let img = dt.itemInfo.productImg {
                    let url = URL(string: img)
                    self.inventoryImageView.kf.setImage(with: url)
                }
                self.inventoryPriceLabel.text = "\(dt.itemInfo.price)"
                self.inventoryListPriceLabel.text = "\(dt.itemInfo.coverPrice)"
                self.inventoryCountToSellLabel.text = "\(dt.itemInfo.quantity)"
                self.inventoryLifeLabel.text = dt.itemInfo.expDate
                self.inventoryDetailLabel.text = dt.itemInfo.itemInfoDescription
                
                self.sellerNameLabel.text = dt.userInfo.repName
                self.storeNameLabel.text = dt.userInfo.coName
                self.storeLocationLabel.text = dt.userInfo.location
                self.sellerPhoneNumber = "0" + dt.userInfo.phoneNumber
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
        
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
