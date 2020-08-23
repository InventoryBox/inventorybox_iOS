//
//  IvRecordVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/02.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class IvRecordVC: UIViewController, UICollectionViewDelegate {
     
     @IBOutlet weak var outView: UIView!
     @IBOutlet weak var topView: UIView!
     @IBOutlet weak var categoryCollectionView: UICollectionView!
     @IBOutlet weak var datePickerBtn: UIButton!
     @IBOutlet weak var datePickerLabelBtn: UIButton!
     @IBOutlet weak var dateLabel: UILabel!
     @IBOutlet weak var categorySettingBtn: UIButton!
     @IBOutlet weak var beforeRecordView: UIView!
     @IBOutlet weak var noDataView: UIView!
     @IBOutlet weak var inventoryTableView: UITableView!
     @IBOutlet weak var popupBackgroundView: UIView!
     
     // 서버에 보낼 현재 날짜 데이터, 쿼리로 전송
     // 2020-08-18 Date 형식으로 저장되어있다.
     var dateToSend: String?
     // datePicker에 현재 날짜가 나오게 하기 위해서 저장한 값
     // Date 형식으로 저장되어있다.
     var memorizeDate: Date?
     var categories: [CategoryInfo] = []
     private var inventoryFilteredArray: [HomeItemInfo] = []
     var inventoryArray: [HomeItemInfo] = [] {
          didSet {
               categoryCollectionView.delegate = self
               categoryCollectionView.dataSource = self
               // "전체" 코드로 누르기
               // 언제나 전체 카테고리는 존재한다.
               if !categories.isEmpty {
                    categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
                    collectionView(self.categoryCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
               }
               inventoryFilteredArray = inventoryArray
          }
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          navigationController?.navigationBar.isHidden = true
          
          if let date = dateToSend {
               getDataFromServer(date)
          } else {
               dateToSend = Date().toString()
               if let data = dateToSend {
                    getDataFromServer(data)
               } else {
                    print("Missing date which needs to send to server")
               }
          }
          
     }
     
     override func viewWillDisappear(_ animated: Bool) {
          
          super.viewWillDisappear(animated)
          navigationController?.navigationBar.isHidden = false
          
          // 재고기록 홈을 나가더라도 다시 돌아올 때 방금 검색한 값이 나오게 하기 위해 날짜 저장
          if let date = memorizeDate {
               dateToSend = date.toString()
          }
          
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          inventoryTableView.delegate = self
          inventoryTableView.dataSource = self
          inventoryTableView.allowsSelection = false
          inventoryTableView.separatorStyle = .none
          // 카테고리 밑 그림자
          outView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
          outView.layer.shadowOpacity = 0.05
          outView.layer.shadowRadius = 2
          setPopupBackgroundView()
     }
     
     private func setPopupBackgroundView() {
          popupBackgroundView.isHidden = true
          popupBackgroundView.alpha = 0
          self.view.bringSubviewToFront(popupBackgroundView)
          // popup에 노티를 걸어준다.
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
          guard let selectedDate = info["selectedDate"] as? Date else { return }
          memorizeDate = selectedDate
          dateLabel.text = selectedDate.toString(withFormat: "yyyy.MM.dd eeee")
          dateToSend = selectedDate.toString()
          if let data = dateToSend {
               getDataFromServer(data)
          } else {
               print("Missing date which needs to send to server")
          }
     }

     deinit {
          NotificationCenter.default.removeObserver(self)
     }
     
     private func getDataFromServer(_ date: String) {
          IvRecordHomeService.shared.getRecordHome(whichDate: date) { (networkResult) in
               switch networkResult {
               case .success(let data):
                    guard let dt = data as? IvRecordHomeClass else { return }
                    // 날짜
                    
                    self.dateLabel.text = dt.date
                    // "2020-08-18" String에서 Date 형태로 바꾸는 함수
                    self.memorizeDate = dt.date.components(separatedBy: " ")[0].toDate(withFormat: "yyyy.MM.dd")
                    
                    // 데이터 정렬
                    self.categories = dt.categoryInfo
                    if let itemInfo = dt.itemInfo {
                         self.inventoryArray = itemInfo
                         //print(self.inventoryArray)
                    }
                    // 오늘 재고기록을 안했을경우, 했을경우, 이전 재고기록을 안했을 경우 분기처리
                    if self.inventoryArray.isEmpty {
                         if date == Date().toString() {
                              self.beforeRecordView.isHidden = false
                              self.noDataView.isHidden = true
                              self.inventoryTableView.isHidden = true
                         } else {
                              self.beforeRecordView.isHidden = true
                              self.noDataView.isHidden = false
                              self.inventoryTableView.isHidden = true
                         }
                    } else {
                         self.beforeRecordView.isHidden = true
                         self.noDataView.isHidden = true
                         self.inventoryTableView.isHidden = false
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
     
     @IBAction func openDatePicker(_ sender: Any) {
          animatePopupBackground(true)
          
          guard let vc = storyboard?.instantiateViewController(withIdentifier: "DatePickerPopupVC") as? DatePickerPopupVC else { return }
          vc.dateMemorized = memorizeDate
          vc.modalPresentationStyle = .overCurrentContext
          self.present(vc, animated: true)
     }

     // 재고량 편집하기
     @IBAction func goToIvRecordEditProduct(_ sender: Any) {
          let IvRecordEditProductST = UIStoryboard.init(name: "IvRecordEditProduct", bundle: nil)
          guard let editProductVC = IvRecordEditProductST.instantiateViewController(identifier: "IvRecordEditProductVC") as? IvRecordEditProductVC else { return }
          editProductVC.dateToSend = memorizeDate?.toString()
          editProductVC.editDate = memorizeDate?.toString(withFormat: "yyyy.MM.dd eeee")
          editProductVC.modalPresentationStyle = .fullScreen
          editProductVC.modalTransitionStyle = .crossDissolve
          NotificationCenter.default.addObserver(self, selector: #selector(sendDataFromEditToHome), name: .init("sendDataFromEditToHome"), object: nil)
          self.present(editProductVC, animated: true, completion: nil)
     }
     
     @objc func sendDataFromEditToHome(_ notification: Notification) {
          guard let info = notification.userInfo as? [String: Any] else { return }
          guard let editInventoryArray = info["editInventoryArray"] as? [EditItemInfo] else { return }
          for item in 0..<inventoryArray.count {
               for i in 0..<editInventoryArray.count {
                    if inventoryArray[item].itemIdx == editInventoryArray[i].itemIdx {
                         inventoryArray[item].stocksCnt = editInventoryArray[i].stocksCnt
                    }
               }
          }
          inventoryFilteredArray = inventoryArray
          inventoryTableView.reloadData()
     }
     
     // 카테고리 편집하기
     @IBAction func goToIvRecordCategoryEdit(_ sender: Any) {
          
          let IvRecordCategoryEditST = UIStoryboard.init(name: "IvRecordCategoryEdit", bundle: nil)
          guard let categoryEditVC = IvRecordCategoryEditST.instantiateViewController(identifier: "IvRecordCategoryEditVC")
               as? IvRecordCategoryEditVC  else {
                    return
          }
          categoryEditVC.modalPresentationStyle = .fullScreen
          
          let dateFormatter = DateFormatter()
          
          dateFormatter.dateFormat = "yyyy-MM-dd"
          dateFormatter.timeZone = NSTimeZone(name: "ko") as TimeZone?
          
          categoryEditVC.dateToSend = dateFormatter.string(from: memorizeDate!)
          self.present(categoryEditVC, animated: false, completion: nil)
          
     }
     
     // 오늘의 재고 기록하기
     @IBAction func goToIvTodayRecord(_ sender: Any) {
          let IvTodayRecord = UIStoryboard.init(name: "IvTodayRecord", bundle: nil)
          guard let IvTodayRecordVC = IvTodayRecord.instantiateViewController(identifier: "IvTodayRecordVC") as? IvTodayRecordVC else { return }
          IvTodayRecordVC.modalPresentationStyle = .fullScreen
          self.present(IvTodayRecordVC, animated: true, completion: nil)
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
          
          return categoryCell
     }
     
     
}

extension IvRecordVC: UICollectionViewDelegateFlowLayout {
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          // 카테고리 필터링 코드
          var allCategoryCheck: Bool = false
          if categories[indexPath.item].name  == "전체" {
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
               guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? AddIvHeaderCell else { return UITableViewCell() }
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

//MARK: - String to Date
extension String {
     func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
          // dateFormatter 생성
          let dateFormatter = DateFormatter()
          // 현재 우리가 저장하고 있는 dateFormat으로 설정
          // 어떤 형식으로 바꿔야할 지 참고하는 사이트 링크 👉 https://nsdateformatter.com
          dateFormatter.dateFormat = format
          // 프린트할 때 하루 늦게 나오기 때문에 써준 코드
          //NSTimeZone.default = TimeZone(abbreviation: "UTC")!
          guard let date = dateFormatter.date(from: self) else {
               preconditionFailure("Take a look to your format")
          }
          return date
     }
}

//MARK: - Date to String
extension Date {
     func toString(withFormat format: String = "yyyy-MM-dd") -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = format
          dateFormatter.locale = Locale(identifier: "ko")
          let date = dateFormatter.string(from: self)
          return date
     }
}
