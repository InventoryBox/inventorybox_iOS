//
//  IvExchangeVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvExchangeVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myLocationLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var allInventoryLabel: UILabel!
    @IBOutlet weak var allInventoryBottomView: UIView!
    @IBOutlet weak var allIvCollectionView: UICollectionView!
    
    @IBOutlet weak var cateStackView: UIStackView!
    @IBOutlet weak var distanceBtn: UIButton!
    @IBOutlet weak var priceBtn: UIButton!
    @IBOutlet weak var recentBtn: UIButton!
    
    var filterNum: String = "0"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        setNotiAddress()
        getDataFromServer(filterNum)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        //        removeNotiAddress()
    }
    var allExchangeArray: [PostInfo] = []
    var filteredExchangeArray: [PostInfo] = []
    
    @IBOutlet weak var foodInventoryLabel: UILabel!
    @IBOutlet weak var foodInventoryBottomView: UIView!
    @IBOutlet weak var foodIvCollectionView: UICollectionView!
    
    let foodExchangeArray: [PostInfo] = []
    
    @IBOutlet weak var productInventoryLabel: UILabel!
    @IBOutlet weak var productInventoryBottomView: UIView!
    @IBOutlet weak var productIvCollectionView: UICollectionView!
    
    let productExchangeArray: [PostInfo] = []
    
    @IBOutlet weak var recentInventoryLabel: UILabel!
    @IBOutlet weak var recentInventoryBottomView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelCustom()
        
        setTabBottomViewCustom()
        setShadow()
        setCollectionView()
        setCateStackView()
        setTextField()
    }
    private func getDataFromServer(_ filter: String) {
        
        IvExchangeHomeService.shared.getExchangeHome(filter: filterNum) { (networkResult) in
            switch networkResult {
            case .success(let data):
                
                guard let dt = data as? IvExchangeHomeClass else { return }
                self.myLocationLabel.text = dt.addressInfo
                
                if self.filterNum == "0" {
                    self.allExchangeArray = dt.postInfo
                    self.filteredExchangeArray = self.allExchangeArray
                    self.allIvCollectionView.reloadData()
                } else if self.filterNum == "1" {
                    self.allExchangeArray = dt.postInfo
                    self.filteredExchangeArray = self.allExchangeArray
                    self.allIvCollectionView.reloadData()
                } else {
                    self.allExchangeArray = dt.postInfo
                    self.filteredExchangeArray = self.allExchangeArray
                    self.allIvCollectionView.reloadData()
                }
                
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
    private func setTextField() {
        searchTextField.delegate = self
    }
    private func setNotiAddress() {
        NotificationCenter.default.addObserver(self, selector: #selector(addressSend), name: .init("name"), object: nil)
    }
    
    private func removeNotiAddress() {
        
        NotificationCenter.default.removeObserver(self, name: .init("name"), object: nil)
    }
    
    @objc private func addressSend(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let name = userInfo["address"] as? String else { return }
        
        myLocationLabel.text = name
    }
    
    private func setCateStackView() {
        cateStackView.layer.borderColor = UIColor.gray.cgColor
        cateStackView.layer.cornerRadius = 12
        distanceBtn.layer.cornerRadius = 12
        priceBtn.layer.cornerRadius = 12
        recentBtn.layer.cornerRadius = 12
        
        distanceBtn.titleLabel?.textColor = .mediumGrey
        priceBtn.titleLabel?.textColor = .mediumGrey
        recentBtn.titleLabel?.textColor = .white
        
        distanceBtn.backgroundColor = .white
        priceBtn.backgroundColor = .white
        recentBtn.backgroundColor = .yellow
    }
    
    @IBAction func distanceBtnPressed(_ sender: Any) {
        
        distanceBtn.titleLabel?.textColor = .white
        priceBtn.titleLabel?.textColor = .mediumGrey
        recentBtn.titleLabel?.textColor = .mediumGrey
        
        distanceBtn.backgroundColor = .yellow
        priceBtn.backgroundColor = .white
        recentBtn.backgroundColor = .white
        
        filterNum = "1"
        getDataFromServer(filterNum)
        
    }
    @IBAction func priceBtnPressed(_ sender: Any) {
        
        distanceBtn.titleLabel?.textColor = .mediumGrey
        priceBtn.titleLabel?.textColor = .white
        recentBtn.titleLabel?.textColor = .mediumGrey
        
        distanceBtn.backgroundColor = .white
        priceBtn.backgroundColor = .yellow
        recentBtn.backgroundColor = .white
        
        filterNum = "2"
        getDataFromServer(filterNum)
    }
    
    @IBAction func recentBtnPressed(_ sender: Any) {
        distanceBtn.titleLabel?.textColor = .mediumGrey
        priceBtn.titleLabel?.textColor = .mediumGrey
        recentBtn.titleLabel?.textColor = .white
        
        distanceBtn.backgroundColor = .white
        priceBtn.backgroundColor = .white
        recentBtn.backgroundColor = .yellow
        
        filterNum = "0"
        getDataFromServer(filterNum)
    }
    
    
    
    @IBAction func allIvBtnPressed(_ sender: Any) {
        
        allInventoryLabel.textColor = UIColor.black
        foodInventoryLabel.textColor = UIColor.gray
        productInventoryLabel.textColor = UIColor.gray
        recentInventoryLabel.textColor = UIColor.gray
        
        allInventoryBottomView.isHidden = false
        foodInventoryBottomView.isHidden = true
        productInventoryBottomView.isHidden = true
        recentInventoryBottomView.isHidden = true
        
        self.filteredExchangeArray = self.allExchangeArray
        allIvCollectionView.reloadData()
        
    }
    
    @IBAction func foodIvBtnPressed(_ sender: Any) {
        allInventoryLabel.textColor = UIColor.gray
        foodInventoryLabel.textColor = UIColor.black
        productInventoryLabel.textColor = UIColor.gray
        recentInventoryLabel.textColor = UIColor.gray
        
        allInventoryBottomView.isHidden = true
        foodInventoryBottomView.isHidden = false
        productInventoryBottomView.isHidden = true
        recentInventoryBottomView.isHidden = true
        
        
        self.filteredExchangeArray = allExchangeArray.filter({ (postInfo) -> Bool in
            return postInfo.isFood == 1
        })
        
        allIvCollectionView.reloadData()
        
    }
    
    @IBAction func productIvBtnPressed(_ sender: Any) {
        allInventoryLabel.textColor = UIColor.gray
        foodInventoryLabel.textColor = UIColor.gray
        productInventoryLabel.textColor = UIColor.black
        recentInventoryLabel.textColor = UIColor.gray
        
        allInventoryBottomView.isHidden = true
        foodInventoryBottomView.isHidden = true
        productInventoryBottomView.isHidden = false
        recentInventoryBottomView.isHidden = true
        
        self.filteredExchangeArray = allExchangeArray.filter({ (postInfo) -> Bool in
            return postInfo.isFood == 0
        })
        
        allIvCollectionView.reloadData()
        
    }
    
    @IBAction func recentIvBtnPressed(_ sender: Any) {
        allInventoryLabel.textColor = UIColor.gray
        foodInventoryLabel.textColor = UIColor.gray
        productInventoryLabel.textColor = UIColor.gray
        recentInventoryLabel.textColor = UIColor.black
        
        allInventoryBottomView.isHidden = true
        foodInventoryBottomView.isHidden = true
        productInventoryBottomView.isHidden = true
        recentInventoryBottomView.isHidden = false
        
        
    }
    private func setLabelCustom() {
        allInventoryLabel.textColor = UIColor.black
        foodInventoryLabel.textColor = UIColor.gray
        productInventoryLabel.textColor = UIColor.gray
        recentInventoryLabel.textColor = UIColor.gray
        
        allInventoryBottomView.isHidden = false
        foodInventoryBottomView.isHidden = true
        productInventoryBottomView.isHidden = true
        recentInventoryBottomView.isHidden = true
    }
    
    private func setTabBottomViewCustom() {
        allInventoryBottomView.layer.cornerRadius = 3
        foodInventoryBottomView.layer.cornerRadius = 3
        productInventoryBottomView.layer.cornerRadius = 3
        
    }
    private func setCollectionView() {
        
        allIvCollectionView.delegate = self
        allIvCollectionView.dataSource = self
        
        foodIvCollectionView.delegate = self
        foodIvCollectionView.dataSource = self
        
        productIvCollectionView.delegate = self
        productIvCollectionView.dataSource = self
        
    }
    private func setShadow() {
        
        topView.layer.shadowOpacity = 0.1
        topView.layer.shadowRadius = 2
        topView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        searchTextField.layer.shadowOpacity = 0.1
        searchTextField.layer.shadowRadius = 2
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        
    }
}

//MARK: - allIvCollectionViewDelegate
extension IvExchangeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredExchangeArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let exchangeCell = collectionView.dequeueReusableCell(withReuseIdentifier: IvAllExchangeCell.identifier, for: indexPath) as? IvAllExchangeCell else { return UICollectionViewCell() }
        
        if allExchangeArray[indexPath.row].distDiff > 1000 {
            exchangeCell.distance = "\(allExchangeArray[indexPath.row].distDiff / 1000)" + "km"
            exchangeCell.isColor = UIColor.gray
        } else {
            exchangeCell.distance = "\(allExchangeArray[indexPath.row].distDiff)" + "m"
            exchangeCell.isColor = UIColor.yellow
        }
        exchangeCell.set(filteredExchangeArray[indexPath.row])
        exchangeCell.delegate = self
        exchangeCell.indexPath = indexPath.row
        
        return exchangeCell
        
    }
    
}

extension IvExchangeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40) / 2, height: 290)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension IvExchangeVC: ExchangeButtonDelegate {
    func whichProductIsSelect(indexPath: Int, idx: Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvExchangeDetailVC") as? IvExchangeDetailVC else { return }
        
        vc.idx = idx
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectHeart(isClicked: Bool, indexPath: Int) {
        allExchangeArray[indexPath].likes = isClicked ? 1: 0
        //        allExchangeArray[indexPath].ivHeart = isClicked
        // 어차피 전체 식품 공산품은 전체에서 필터링을 할거기때문에 찜하기는 전체에만 반영하고 다시 필터링을 해주면 된다.
    }
}

//MARK: - TextFieldDelegate
extension IvExchangeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
}

