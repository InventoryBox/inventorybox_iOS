//
//  IvProductRegistVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvProductRegistVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet var productNameTextField: UITextField!
    @IBOutlet var productCountTextField: UITextField!
    @IBOutlet var salesPriceTextField: UITextField!
    @IBOutlet var originalPriceTextField: UITextField!
    @IBOutlet var productExplainTextView: UITextView!
    @IBOutlet var personalInfoView: UIView!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var productCategoryBtn: UIButton!
    @IBOutlet var foodCategoryBtn: UIButton!
    @IBOutlet var dateBtn: UIButton!
    @IBOutlet var productImg: UIButton!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var popupBackgroundView: UIView!
    @IBOutlet var unitTextField: UITextField!
    var isFood:Int = 1
    var expDateMemorize: String = ""
    var productImage:UIImage?
    var productImageName:String = ""
    var realCountText:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setPopupBackgroundView()
        salesPriceTextField.delegate = self
        originalPriceTextField.delegate = self
        productCountTextField.delegate = self
        unitTextField.delegate = self
    }
    
    func setView(){
        let grayColor = UIColor.pinkishGrey
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        headerView.layer.shadowOpacity = 0.1
        productExplainTextView.layer.borderColor = grayColor.cgColor
        productExplainTextView.layer.cornerRadius = 9
        productExplainTextView.layer.borderWidth = 1
        productNameTextField.addLeftPadding()
        productNameTextField.borderStyle = .roundedRect
        productCountTextField.addLeftPadding()
        productCountTextField.layer.borderColor = .init(srgbRed: 246/255, green: 187/255, blue: 51/255, alpha: 1.0)
        let myColor = UIColor.yellow
        productCountTextField.layer.borderColor = myColor.cgColor
        productCountTextField.layer.borderWidth = 1.0
        productCountTextField.layer.cornerRadius = 9
        salesPriceTextField.layer.borderColor = grayColor.cgColor
        salesPriceTextField.layer.borderWidth = 1.0
        salesPriceTextField.layer.cornerRadius = 9
        foodCategoryBtn.layer.shadowOpacity = 0.2
        foodCategoryBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        productCategoryBtn.layer.shadowOpacity = 0.2
        productCategoryBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        productCategoryBtn.layer.cornerRadius = 9
        originalPriceTextField.layer.borderColor = grayColor.cgColor
        originalPriceTextField.layer.borderWidth = 1
        originalPriceTextField.layer.cornerRadius = 9
        personalInfoView.layer.cornerRadius = 9
        personalInfoView.layer.shadowOffset = CGSize(width: 0, height: 0)
        personalInfoView.layer.shadowOpacity = 0.1
        confirmBtn.layer.cornerRadius = 25
        productImg.imageView?.layer.cornerRadius = 9
        yearLabel.layer.cornerRadius = 9
        monthLabel.layer.cornerRadius = 9
        dayLabel.layer.cornerRadius = 9
        
    }

    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func pickPhotoFromAlbumBtn(_ sender: UIButton) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            productImageName = url.lastPathComponent
            productImage = image
            self.productImg.setImage(image, for: .normal)
        }
        self.dismiss(animated: true, completion: nil) }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) { self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
        
    }
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let year = info["year"] as? String else { return }
        guard let month = info["month"] as? String else {return}
        guard let day = info["day"] as? String else {return}
        
        yearLabel.text = year
        monthLabel.text = month
        dayLabel.text = day
        expDateMemorize = year + "." + month + "." + day
        print(expDateMemorize)
        
    }

    
    @IBAction func dayPickerBtn(_ sender: UIButton) {
        animatePopupBackground(true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvExchangeWritePopupVC") as? IvExchangeWritePopupVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func plusCountBtn(_ sender: UIButton) {
    }
    @IBAction func minusCountBtn(_ sender: UIButton) {
    }
    @IBAction func categoryFoodPickBtn(_ sender: UIButton) {
    }
    @IBAction func categoryProductPickBtn(_ sender: UIButton) {
    }
    @IBAction func dismissBtn(_ sender: UIButton) {
        print("btn")
         guard let productImg = productImg.imageView?.image else {
            print("img")
            return}
                guard let productName = productNameTextField.text else {
                    print("productName")
                    return}
            guard let price = Int(salesPriceTextField.text!) else {
                print("price")
                return}
        var countText = productCountTextField.text?.components(separatedBy: ",")
        realCountText = countText!.joined()
         guard let quantity = Int(realCountText) else {print("quantity")
                    return}
            guard let textDesctiption = productExplainTextView.text else {print("textDesctiption")
                return}
            guard let coverPrice = Int(originalPriceTextField.text!) else {print("coverPrice")
                return}
            guard let unit = unitTextField.text else {print("unit")
                return}
         
            IvExchangePostService.shared.uploadIvExchangePost(productImageName, productImage!, productName, isFood, price, quantity, expDateMemorize, textDesctiption, coverPrice, unit, completion: { networkResult in
                switch networkResult{
                case .success(let token):
                    print(token)
                    print("success")
                case .requestErr(let message):
                    guard let message = message as? String else {return}
                    print(message)
                case .serverErr: print("serverErr")
                case .pathErr:
                    print("pathErr")
                case .networkFail:
                    print("networkFail")
                }
            })
        self.dismiss(animated: true, completion: nil)
    }
}


extension IvProductRegistVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // replacementString : 방금 입력된 문자 하나, 붙여넣기 시에는 붙여넣어진 문자열 전체
        // return -> 텍스트가 바뀌어야 한다면 true, 아니라면 false
        // 이 메소드 내에서 textField.text는 현재 입력된 string이 붙기 전의 string
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1,000,000
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
        
        // formatter.groupingSeparator // .decimal -> ,
        if textField == salesPriceTextField {
            if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
                var beforeForemattedString = removeAllSeprator + string
                if formatter.number(from: string) != nil {
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        salesPriceTextField.text = formattedString
                        return false
                    }
                }else{ // 숫자가 아닐 때먽
                    if string == "" { // 백스페이스일때
                        let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                        beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                        if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                            salesPriceTextField.text = formattedString
                            return false
                        }
                    }else{ // 문자일 때
                        return false
                    }
                }
                
            }
            
        }
        if textField == originalPriceTextField {
            if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
                var beforeForemattedString = removeAllSeprator + string
                if formatter.number(from: string) != nil {
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        originalPriceTextField.text = formattedString
                        return false
                    }
                }else{ // 숫자가 아닐 때먽
                    if string == "" { // 백스페이스일때
                        let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                        beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                        if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                            originalPriceTextField.text = formattedString
                            return false
                        }
                    }else{ // 문자일 때
                        return false
                    }
                }
            }
        }
        if textField == productCountTextField {
            if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
                var beforeForemattedString = removeAllSeprator + string
                if formatter.number(from: string) != nil {
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        productCountTextField.text = formattedString
                        return false
                    }
                }else{ // 숫자가 아닐 때먽
                    if string == "" { // 백스페이스일때
                        let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                        beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                        if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                            productCountTextField.text = formattedString
                            return false
                        }
                    }else{ // 문자일 때
                        return false
                    }
                }
            }
            
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.unitTextField.endEditing(true)
        productExplainTextView.endEditing(true)
        return true
    }
}

