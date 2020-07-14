//
//  IvRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/02.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class IvRecordVC: UIViewController {
     
     
     @IBOutlet weak var outView: UIView!
     @IBOutlet weak var topView: UIView!
     @IBOutlet weak var categoryCollectionView: UICollectionView!
     
     @IBOutlet weak var datePickerBtn: UIButton!
     @IBOutlet weak var datePickerLabelBtn: UIButton!
     @IBOutlet weak var dateLabel: UILabel!
     
     @IBOutlet weak var categorySettingBtn: UIButton!
     @IBOutlet weak var floatingUpBtn: UIButton!
     @IBOutlet weak var floatingTodayRecordBtn: UIButton!
     
     @IBOutlet weak var firstRegisterView: UIView!
     @IBOutlet weak var firstRegisterBtn: UIButton!
     @IBOutlet weak var noDataView: UIView!
     @IBOutlet weak var inventoryTableView: UITableView!
     
     @IBOutlet weak var popupBackgroundView: UIView!
     
     var dateToSend: String = "0"
     
     var memorizeDate: Date?
     
     var categories: [CategoryInfo] = []
     
     var inventoryArray: [HomeItemInfo] = []
     
     private var inventoryFilteredArray: [HomeItemInfo] = []
     
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
          
          setInventoryFilteredData()
          
          isTodayRecordDone()
          
          whichViewWillShow()
          
          setBtnsCustommed()
          
          setInventoryTableView()
          
          makeShadowUnderOutView()
          
          setPopupBackgroundView()
          
          setCategoryCollectionView()
          
          getDataFromServer(dateToSend)
     }
     
     private func getDataFromServer(_ date: String) {
          
          IvRecordHomeService.shared.getRecordHome(whichDate: date) { (networkResult) in
               switch networkResult {
               case .success(let data):
                    guard let dt = data as? IvRecordHomeClass else { return }
                    
                    // 데이터 정렬
                    self.categories = dt.categoryInfo
                    if let itemInfo = dt.itemInfo {
                         self.inventoryArray = itemInfo
                         print(self.inventoryArray)
                         
                    }
                    
                    
                    // 날짜 검색 ❌ 데이터 ❌ + 날짜 검색 ⭕️ 데이터 ❌
                    // 즉 첫 사용자 로직 + 날짜 검색해서 데이터가 없을때 로직
                    if self.inventoryArray.count == 0 {
                         // 앱잼 때 구현 X
                         
                         // 데이터 피커 날짜 정하는 로직
                         
                         self.firstRegisterView.isHidden = (dt.picker == 0) ? false : true
                         self.noDataView.isHidden = (dt.picker == 0) ? true : false
                         self.inventoryTableView.isHidden = (dt.picker == 0) ? true : true
                    } else { // 가장 최근 재고량 데이터 불러오기
                         
                         if let date = dt.date {
                              self.dateLabel.text = date
                         }
                         
                         
                         self.whichViewWillShow()
                         // 테이블 리로드시키기
                         self.categoryCollectionView.reloadData()
                         self.inventoryTableView.reloadData()
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
     private func setCategoryCollectionView() {
          categoryCollectionView.delegate = self
          categoryCollectionView.dataSource = self
          
     }
     private func setInventoryFilteredData() {
          inventoryFilteredArray = inventoryArray
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
          guard let showDate = info["showDate"] as? String else { return }
          guard let dateMemorize = info["dateMemorize"] as? Date else { return }
        guard let sendDate = info["sendDate"] as? String else { return }
          memorizeDate = dateMemorize
          dateLabel.text = showDate
          dateToSend = sendDate
          getDataFromServer(dateToSend)
     }
     
     @IBAction func openDatePicker(_ sender: Any) {
          animatePopupBackground(true)
          
          guard let vc = storyboard?.instantiateViewController(withIdentifier: "DatePickerPopupVC") as? DatePickerPopupVC else { return }
          vc.dateMemorized = memorizeDate
          vc.modalPresentationStyle = .overCurrentContext
          self.present(vc, animated: true)
     }
     
     deinit {
          NotificationCenter.default.removeObserver(self)
     }
     
     @IBAction func goToIvRecordAddProduct(_ sender: Any) {
          let IvRecordAddProductST = UIStoryboard.init(name: "IvRecordAddProduct", bundle: nil)
          guard let addProductVC = IvRecordAddProductST.instantiateViewController(identifier: "IvRecordNaviVC")
               as? IvRecordNaviVC  else {
                    return
          }
          addProductVC.modalPresentationStyle = .fullScreen
          
          self.present(addProductVC, animated: true, completion: nil)
     }
     
     @IBAction func goToIvRecordEditProduct(_ sender: Any) {
          let IvRecordEditProductST = UIStoryboard.init(name: "IvRecordEditProduct", bundle: nil)
          guard let editProductVC = IvRecordEditProductST.instantiateViewController(identifier: "IvRecordEditProductVC")
               as? IvRecordEditProductVC  else {
                    return
          }
          editProductVC.modalPresentationStyle = .fullScreen
          
          self.present(editProductVC, animated: false, completion: nil)
     }
     @IBAction func goToIvRecordCategoryEdit(_ sender: Any) {
          
          let IvRecordCategoryEditST = UIStoryboard.init(name: "IvRecordCategoryEdit", bundle: nil)
          guard let categoryEditVC = IvRecordCategoryEditST.instantiateViewController(identifier: "IvRecordCategoryEditVC")
               as? IvRecordCategoryEditVC  else {
                    return
          }
          categoryEditVC.modalPresentationStyle = .fullScreen
          
          self.present(categoryEditVC, animated: false, completion: nil)
          
     }
     
     @IBAction func goToIvTodayRecord(_ sender: Any) {
          
          let IvTodayRecord = UIStoryboard.init(name: "IvTodayRecord", bundle: nil)
          guard let IvTodayRecordVC = IvTodayRecord.instantiateViewController(identifier: "IvTodayRecordVC")
               as? IvTodayRecordVC  else {
                    return
          }
          IvTodayRecordVC.modalPresentationStyle = .fullScreen
          
          self.present(IvTodayRecordVC, animated: true, completion: nil)
          
     }
     
     
     @IBAction func scrollUpBtnPressed(_ sender: Any) {
          
          let indexPath = IndexPath(row: 0, section: 0)
          self.inventoryTableView.scrollToRow(at: indexPath, at: .top, animated: false)
          
     }
     
     private func isTodayRecordDone() {
          // 오늘 기록을 했다면
          floatingUpBtn.isHidden = true
          
          // 오늘 기록을 하지 않았다면
          floatingUpBtn.isHidden = false
     }
     
     private func whichViewWillShow() {
          
          firstRegisterView.isHidden = true
          noDataView.isHidden = true
          inventoryTableView.isHidden = false
          
     }
     
     private func setBtnsCustommed() {
          
          floatingTodayRecordBtn.layer.cornerRadius = 18
          floatingTodayRecordBtn.backgroundColor = UIColor.yellow
          floatingTodayRecordBtn.tintColor = UIColor.white
          
          firstRegisterBtn.layer.cornerRadius = 18
          firstRegisterBtn.backgroundColor = UIColor.yellow
          firstRegisterBtn.tintColor = UIColor.white
          
          
     }
     
     private func makeShadowUnderOutView() {
          
          self.outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
          self.outView.layer.shadowOpacity = 0.05
          self.outView.layer.shadowRadius = 2
          
     }
     
     //    private func addCategoryCollectionView() {
     //
     //        view.addSubview(categoryCollectionView)
     //        categoryCollectionView.delegate = self
     //        categoryCollectionView.setCategoryCollectionView()
     //        //        categoryCollectionView.
     //        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
     //        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
     //        categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
     //        categoryCollectionView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 8).isActive = true
     //
     //        categoryCollectionView.addTags(categories, with: categoryCollectionView.setCategoryConfig())
     //
     //    }
     
     //    private func setBackgroundColor() {
     //
     //    }
     
     private func setInventoryTableView() {
          
          inventoryTableView.delegate = self
          inventoryTableView.dataSource = self
          
          inventoryTableView.allowsSelection = false
          inventoryTableView.separatorStyle = .none
          
     }
     
     
     
}

//MARK: - CollectionView

extension IvRecordVC: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return categories.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
          
          
          categoryCell.setTag(tagName: categories[indexPath.row].name)
          
          //        categoryCell.wholeSetting(selections.contains("전체"))
          
          return categoryCell
     }
     
     
}

extension IvRecordVC: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
          print(categories[indexPath.row])
          // 카테고리 필터링 코드
          
          var allCategoryCheck: Bool = false
          
          if categories[indexPath.row].name  == "전체" {
               allCategoryCheck = true
               inventoryFilteredArray = inventoryArray
               inventoryTableView.reloadData()
          }
          
          
          if !allCategoryCheck {
               
               inventoryFilteredArray = []
               let filtered = inventoryArray.filter { (inventory) -> Bool in
                    return inventory.categoryIdx == categories[indexPath.row].categoryIdx
               }
               
               for data in filtered {
                    inventoryFilteredArray.append(data)
               }
               
               inventoryTableView.reloadData()
               
          }
          
          
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
          
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: self.view.frame.width, height: 24)
     }
}

//MARK: - InventoryTableView
extension IvRecordVC: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
          return inventoryFilteredArray.count + 1
          
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if indexPath.row == 0 {
               guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
               
               return headerCell
               
          } else {
               
               guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCell.identifier, for: indexPath) as? InventoryCell else { return UITableViewCell() }
               
               inventoryCell.setInventoryData(inventoryFilteredArray[indexPath.row - 1].img, inventoryFilteredArray[indexPath.row - 1].name, inventoryFilteredArray[indexPath.row - 1].alarmCnt, inventoryFilteredArray[indexPath.row - 1].unit, inventoryFilteredArray[indexPath.row - 1].stocksCnt)
               
               return inventoryCell
               
          }
          
     }
     
     
}

extension IvRecordVC: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
          if indexPath.row == 0 {
               
               return 35
               
          } else {
               
               return 102
               
          }
          
     }
}
