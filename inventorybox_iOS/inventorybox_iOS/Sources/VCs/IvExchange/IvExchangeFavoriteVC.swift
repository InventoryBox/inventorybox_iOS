//
//  IvExchangeFavoriteVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvExchangeFavoriteVC: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var informations : [IvExchangeFavoriteInformation] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInformations()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
    }
    
    func  setInformations(){
        let data1 = IvExchangeFavoriteInformation(postIdx: 1, productImg: "homeImgProfile", productName: "일회용샐러드팩", price: 200, expDate: "2020.09.13", isSold: 0, uploadDate: "2020년 07월 16일", likes: 1)
        let data2 = IvExchangeFavoriteInformation(postIdx: 2, productImg: "homeImgProfile", productName: "우유우유", price: 323000, expDate: "2020.09.13", isSold: 0, uploadDate: "2020년 07월 16일", likes: 0)
        let data3 = IvExchangeFavoriteInformation(postIdx: 3, productImg: "homeImgProfile", productName: "야호", price: 30100, expDate: "2020.09.13", isSold: 0, uploadDate: "2020년 07월 16일", likes: 1)
        let data4 = IvExchangeFavoriteInformation(postIdx: 4, productImg: "homeImgProfile", productName: "맛남", price: 23000, expDate: "2020.09.13", isSold: 0, uploadDate: "2020년 07월 16일", likes: 0)
        let data5 = IvExchangeFavoriteInformation(postIdx: 5, productImg: "homeImgProfile", productName: "쩝쩝", price: 30, expDate: "2020.09.13", isSold: 0, uploadDate: "2020년 07월 16일", likes: 1)
        let data6 = IvExchangeFavoriteInformation(postIdx: 6, productImg: "homeImgProfile", productName: "냠냠", price: 1200, expDate: "2020.09.13", isSold: 0, uploadDate: "2020년 07월 16일", likes: 1)
        
        informations = [data1, data2, data3, data4, data5, data6]
    }

    @IBAction func backIvBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension IvExchangeFavoriteVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return informations.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IvExchangeFavoriteCVCell.identifier, for: indexPath) as? IvExchangeFavoriteCVCell else {return UICollectionViewCell()}

            cell.set(informations[indexPath.row])
           
        return cell
       
    }
}

extension IvExchangeFavoriteVC: UICollectionViewDelegateFlowLayout {
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

//MARK: - TextFieldDelegate
extension IvExchangeFavoriteVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
}
