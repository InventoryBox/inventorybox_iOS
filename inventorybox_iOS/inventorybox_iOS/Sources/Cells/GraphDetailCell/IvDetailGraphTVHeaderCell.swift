//
//  IvDetailGraphTVHeaderCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let clickWeek = NSNotification.Name("clickWeek")
    static let setWeek = NSNotification.Name("setWeek")
}

class IvDetailGraphTVHeaderCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var thisMonthWeekInfoCV: UICollectionView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    
    var itemGraphData:[GraphInfo] = []
    var weekBtnArray:[String] = []
    var getWeekCount:Int = 0
    var graphCount:Int = 0
    var weekBtnText:String?
    let date = Date()
    let calendar = Calendar.current
    var collectionArray:[WeekInformation] = [] {
        didSet {
            print("왜ㅗ애",collectionArray)
        }
    }
    var weekArray:[SingleGraphWeekInfo] = []
    var itemIdx:Int = 0
    //버튼의 진짜 초기값. 이 상태대로 첫 noti가 실행됨. Noti 실행-> tableviewcell 바뀜
    // var weekBtnIsSelectedStatus:Bool = true
   
    
    override func awakeFromNib() {
        self.thisMonthWeekInfoCV.reloadData()

        thisMonthWeekInfoCV.delegate = self
        thisMonthWeekInfoCV.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(setStatus(_:)), name: .clickWeek, object: nil)

    }
    
    override func prepareForReuse(){
        self.thisMonthWeekInfoCV.reloadData()

        thisMonthWeekInfoCV.delegate = self
        thisMonthWeekInfoCV.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(setStatus(_:)), name: .clickWeek, object: nil)
    }

    
    @objc func setStatus(_ notification: NSNotification) {
        //cell 안의 버튼이 눌리면 cell status를 반대로 바꿔주는 함수
        //status가 반대로 되어있음
        
        guard let row = notification.userInfo?["week"] as? Int else { return }
        var status = notification.userInfo?["status"] as? Bool
        
        print("setStatusFromNoti")
        
        if status == true {
            collectionArray[row].btnIsSelected = status!
            print("false로 바뀌어라",collectionArray)
        }
        else {
            collectionArray[row].btnIsSelected = status!
            print("true로 바뀌어라",collectionArray)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("firstcount",collectionArray.count)
        return collectionArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekInThisMonthCVCell", for: indexPath) as! WeekInThisMonthCVCell
        cell.weekBtn.setTitle(collectionArray[indexPath.row].btnText, for: .normal)
        cell.weekBtn.layer.cornerRadius = 9
        
        //제일 먼저 실행됨
        cell.status = collectionArray[indexPath.row].btnIsSelected
        print(collectionArray[indexPath.row].btnIsSelected)
        cell.week = indexPath.row
        print("예예에에에ㅔㅇ",cell.status)
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
