//
//  IvGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts
import Kingfisher
//import TTGTagCollectionView



class IvGraphVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var headerView: UIView!
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var ivDataTableView: UITableView!
    @IBOutlet var tagCollectionView: UICollectionView!
    
    
    private var dayList: [String] = []
    
    private var itemList:[ItemInfo] = []
    
    private var tagArray:[CategoryInfo] = [] {
        didSet {
            tagCollectionView.reloadData()
            tagCollectionView.delegate = self
            tagCollectionView.dataSource = self
//            tagCollectionView.reloadData()
            tagCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)

            collectionView(self.tagCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        }
    }
    private var itemFilteredArray: [ItemInfo] = []
    private var selections = [String]()
   
    
    var numbers:[Double] = []
    var days: [String] = ["일","월","화","수","목","금","토"]
    
       
    
    // 이 값 순서대로 그래프가 그려짐
    // 서버통신 시 inventory별 정보 배열이 들어갈 곳
    let uniteSold = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //view에 shadow
        headerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        headerView.layer.shadowOpacity = 0.08
        
    
        //collectionView 정의
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.layer.cornerRadius = 10
//        calendarCollectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0) as! CGColor
        calendarCollectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        calendarCollectionView.layer.shadowOpacity = 0.1
        calendarCollectionView.layer.shadowRadius = 3
        calendarCollectionView.clipsToBounds = false
        calendarCollectionView.layer.masksToBounds = false
        
       
        //day 데이터 setting
        
        
        
        //tableView
        ivDataTableView.delegate = self
        ivDataTableView.dataSource = self
        
        
        //item 데이터 setting
        
        
        //tableView 구분선 제거
        ivDataTableView.separatorStyle = .none
        self.navigationController?.navigationBar.isHidden = true
        
      
        //categoryTabView.selectionLimit = 1
        itemFilteredArray = itemList
        
        
        getDataFromServer()
        print(dayList.count)
        print(itemList.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func getDataFromServer(){
        
        InventoryGraphHomeService.shared.loadHome { networkResult in
            switch networkResult{
            case .success(let token):
                print(token)
                guard let data = token as? ThisWeekData else {return}
                self.dayList = data.thisWeekDates
                print(self.dayList)
                self.itemList = data.itemInfo
                self.tagArray = data.categoryInfo
                print(self.tagArray.count)
                print(self.tagArray)
                DispatchQueue.main.async {
                    self.calendarCollectionView.reloadData()
//                    self.tagCollectionView.reloadData()
                }
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == calendarCollectionView {
            return dayList.count
        }
        
       else if collectionView == tagCollectionView {
            return tagArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == calendarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCVCell
            cell.dayLabel.text = dayList[indexPath.row]
            cell.dayOfWeekLabel.text = days[indexPath.row]
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            
            if (dayList[indexPath.row] == "\(day)"){
                
                cell.selectImg.image = UIImage(named: "dataShapeDateYellow")
                print("dataShapeDateYellow")
                cell.dayOfWeekLabel.textColor = .white
                cell.dayLabel.textColor = .white
            }
            else{
                
                cell.selectImg.image = UIImage(named: "dataShapeDateWhite")
                print("dataShapeDateWhite")
                cell.dayOfWeekLabel.textColor = .noname
                cell.dayLabel.textColor = .charcoal
            }
            
            return cell
        }
            
        else if collectionView == tagCollectionView {
            let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionCell", for: indexPath) as! TagCollectionViewCell
            tagCell.bind(model: tagArray[indexPath.row])
            tagCell.layer.cornerRadius = 11
            tagCell.layer.borderColor = CGColor(srgbRed: 154/255, green: 154/255, blue: 154/255, alpha: 1.0)
            tagCell.layer.borderWidth = 0.5
            
            return tagCell
        }
        return UICollectionViewCell()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemFilteredArray.count + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //셀 재사용 문제 해결하기
    
        if indexPath.row == 0 {
            
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "headerCell",for: indexPath) as? IvTVHeaderCell else {return UITableViewCell()}
            cell2.ivItemTVheaderLabel.textColor = .noname
            
            return cell2
        }
            
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemDataCell", for:indexPath) as? IvGraphTVCell else {return UITableViewCell()}
            cell.removeLimitLine()
            cell.bind(model: itemFilteredArray[indexPath.row - 1])
//            if((cell.accessCell?.stocks[indexPath.row])! < 1){
//                cell.accessCell?.stocks[indexPath.row] = 0
//            }
            
                  
            return cell
        }
      }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        //기기 사이즈 맞춰서 142 생각하기
        
        if indexPath.row == 0 {
           return 60
        }
        else {
            return 142
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier:
            "IvDetailGraphVC") as? IvDetailGraphVC else { return }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        //이 때, "현재 기준"으로 indexPath.row에 해당하는 데이터를 받아와야함
        detailViewController.itemName = self.itemFilteredArray[indexPath.row - 1].name
        detailViewController.itemIdx = self.itemFilteredArray[indexPath.row - 1].itemIdx
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? IvGraphTVCell else { return }
        cell.removeLimitLine()
    }
    
}

extension IvGraphVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tagCollectionView {
            print(tagArray[indexPath.row])
            // 카테고리 필터링 코드
            
            var allCategoryCheck: Bool = false
            
            if tagArray[indexPath.row].name  == "전체" {
                allCategoryCheck = true
                itemFilteredArray = itemList
                ivDataTableView.reloadData()
            }
            
            
            if !allCategoryCheck {
                
                itemFilteredArray = []
                let filtered = itemList.filter { (inventory) -> Bool in
                    return inventory.categoryIdx == tagArray[indexPath.row].categoryIdx
                }
                
                for data in filtered {
                    itemFilteredArray.append(data)
                }
                
                ivDataTableView.reloadData()
                
            }
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: 24)
//    }
}

    
    
   

