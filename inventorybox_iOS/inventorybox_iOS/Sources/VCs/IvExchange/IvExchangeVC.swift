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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        setNotiAddress()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
//        removeNotiAddress()
    }
    var allExchangeArray: [AllExchangeInformation] = {
       let data1 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data2 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data3 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data4 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data5 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data6 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data7 = AllExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        
        return [data1, data2, data3, data4, data5, data6, data7]
    }()
    
    
    @IBOutlet weak var foodInventoryLabel: UILabel!
    @IBOutlet weak var foodInventoryBottomView: UIView!
    @IBOutlet weak var foodIvCollectionView: UICollectionView!
    
    let foodExchangeArray: [FoodExchangeInformation] = {
       let data1 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data2 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data3 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data4 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data5 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data6 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data7 = FoodExchangeInformation(imageName: "24", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        
        return [data1, data2, data3, data4, data5, data6, data7]
    }()
    
    @IBOutlet weak var productInventoryLabel: UILabel!
    @IBOutlet weak var productInventoryBottomView: UIView!
    @IBOutlet weak var productIvCollectionView: UICollectionView!
    
    let productExchangeArray: [ProductExchangeInformation] = {
       let data1 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data2 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data3 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data4 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data5 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data6 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        let data7 = ProductExchangeInformation(imageName: "KakaoTalk_Photo_2020-07-08-21-55-55", heart: false, price: "7000원", distance: "100m", name: "녹차 라떼 파우더", life: "유통기한 2020.12.23", date: "2020년 12월 21일 작성")
        
        return [data1, data2, data3, data4, data5, data6, data7]
    }()
    
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
        
//        print(name)
        myLocationLabel.text = name
    }
    private func setCateStackView() {
        cateStackView.layer.borderColor = UIColor.gray.cgColor
        cateStackView.layer.cornerRadius = 12
        distanceBtn.layer.cornerRadius = 12
        priceBtn.layer.cornerRadius = 12
        recentBtn.layer.cornerRadius = 12
        
        distanceBtn.titleLabel?.textColor = .white
        priceBtn.titleLabel?.textColor = .mediumGrey
        recentBtn.titleLabel?.textColor = .mediumGrey
        
        distanceBtn.backgroundColor = .yellow
        priceBtn.backgroundColor = .white
        recentBtn.backgroundColor = .white
    }
    
    @IBAction func distanceBtnPressed(_ sender: Any) {
        
        distanceBtn.titleLabel?.textColor = .white
        priceBtn.titleLabel?.textColor = .mediumGrey
        recentBtn.titleLabel?.textColor = .mediumGrey
        
        distanceBtn.backgroundColor = .yellow
        priceBtn.backgroundColor = .white
        recentBtn.backgroundColor = .white
    }
    @IBAction func priceBtnPressed(_ sender: Any) {
        
        distanceBtn.titleLabel?.textColor = .mediumGrey
        priceBtn.titleLabel?.textColor = .white
        recentBtn.titleLabel?.textColor = .mediumGrey
        
        distanceBtn.backgroundColor = .white
        priceBtn.backgroundColor = .yellow
        recentBtn.backgroundColor = .white
    }
    
    @IBAction func recentBtnPressed(_ sender: Any) {
        distanceBtn.titleLabel?.textColor = .mediumGrey
        priceBtn.titleLabel?.textColor = .mediumGrey
        recentBtn.titleLabel?.textColor = .white
        
        distanceBtn.backgroundColor = .white
        priceBtn.backgroundColor = .white
        recentBtn.backgroundColor = .yellow
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
        
        allIvCollectionView.isHidden = false
        foodIvCollectionView.isHidden = true
        productIvCollectionView.isHidden = true
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
        
        allIvCollectionView.isHidden = true
        foodIvCollectionView.isHidden = false
        productIvCollectionView.isHidden = true
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
        
        allIvCollectionView.isHidden = true
        foodIvCollectionView.isHidden = true
        productIvCollectionView.isHidden = false
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
        
//        allInventoryBottomView.isHidden = false
//        foodInventoryBottomView.isHidden = true
//        productInventoryBottomView.isHidden = true
        
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
        if collectionView == allIvCollectionView {
            return allExchangeArray.count
        } else if collectionView == foodIvCollectionView {
            return foodExchangeArray.count
        } else {
            return productExchangeArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == allIvCollectionView {
            guard let allExchangeCell = collectionView.dequeueReusableCell(withReuseIdentifier: IvAllExchangeCell.identifier, for: indexPath
                ) as? IvAllExchangeCell  else { return UICollectionViewCell() }
            allExchangeCell.set(allExchangeArray[indexPath.row])
            allExchangeCell.delegate = self
            allExchangeCell.indexPath = indexPath.row
            return allExchangeCell
        } else if collectionView == foodIvCollectionView {
            guard let foodExchangeCell = collectionView.dequeueReusableCell(withReuseIdentifier: IvFoodExchangeCell.identifier, for: indexPath
                ) as? IvFoodExchangeCell  else { return UICollectionViewCell() }
            foodExchangeCell.set(foodExchangeArray[indexPath.row])
            foodExchangeCell.delegate = self
            foodExchangeCell.indexPath = indexPath.row
            
            return foodExchangeCell
        } else {
            guard let productExchangeCell = collectionView.dequeueReusableCell(withReuseIdentifier: IvProductExchangeCell.identifier, for: indexPath
                ) as? IvProductExchangeCell  else { return UICollectionViewCell() }
            productExchangeCell.set(productExchangeArray[indexPath.row])
            productExchangeCell.delegate = self
            productExchangeCell.indexPath = indexPath.row
            return productExchangeCell
        }
        
        
    }
    
}

extension IvExchangeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40) / 2, height: 274)
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
    func whichProductIsSelect(indexPath: Int) {
        print(indexPath)
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    func didSelectHeart(isClicked: Bool, indexPath: Int) {
        allExchangeArray[indexPath].ivHeart = isClicked
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
