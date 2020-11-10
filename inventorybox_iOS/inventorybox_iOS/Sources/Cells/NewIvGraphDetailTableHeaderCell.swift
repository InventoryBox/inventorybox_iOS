//
//  NewIvGraphDetailTableHeaderCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class NewIvGraphDetailTableHeaderCell: UITableViewCell {

    @IBOutlet var weekCV: UICollectionView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var weekInfoCV: UICollectionView!


    let date = Date()
    let calendar = Calendar.current
    var itemIdx:Int = 0
    
    var weekArray:[WeekInformation] = []
    var itemWeekData:[SingleGraphWeekInfo] = []
    var getWeekCount:Int = 0
    var weekBtnText:String = ""
    var graphCount:Int = 0
    
    
    
    override func prepareForReuse() {
        getDataFromServer()
        weekInfoCV.delegate = self
        weekInfoCV.dataSource = self
    }

//    override func awakeFromNib() {
//        getDataFromServer()
//        weekInfoCV.delegate = self
//        weekInfoCV.dataSource = self
//    }

    
    func getDataFromServer(){
        print (itemIdx)
        SingleGraphLoadService.shared.loadCompareGraph(itemIdx, (calendar.component(.year, from: date)), (calendar.component(.month, from: date)), completion:  { networkResult in
                   switch networkResult{
                   case .success(let data):
                       guard let singleGraphData = data as? SingleGraphWeekInfo else {
                           return }
                       
                       self.itemWeekData = [singleGraphData]
                       self.getWeekCount = singleGraphData.weeksCnt
                    print(self.getWeekCount)
                       
                    for i in 0...self.getWeekCount - 1 {
                        
                        
                        if i == 0 {
                            self.weekBtnText = "첫째주"
                        } else if i == 1 {
                            self.weekBtnText = "둘째주"
                        } else if i == 2 {
                            self.weekBtnText = "셋째주"
                        } else if i == 3 {
                            self.weekBtnText = "넷째주"
                        } else if i == 4 {
                            self.weekBtnText = "다섯째주"
                        } else if i == 5 {
                            self.weekBtnText = "여섯째주"
                        } else {
                            self.weekBtnText = "일곱째주"
                        }
                        
                        if self.graphCount < self.getWeekCount {
                            self.weekArray.append(WeekInformation(btnText: self.weekBtnText, btnIsSelected: true))
                            self.graphCount += 1
                        }
                        
                    }
                        
                       DispatchQueue.main.async {
                        
                           self.weekInfoCV.reloadData()
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
               })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension NewIvGraphDetailTableHeaderCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewWeekInfoCVCell", for: indexPath) as! NewWeekInfoCVCell
        
        cell.weekLabel.text = weekArray[indexPath.row].btnText
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForRow(at: indexPath) as? NewWeekInfoCVCell else {return}
        guard let index = collectionView.indexPath(for: cell) else { return }

      
        if index.row == index.row {
            if index!.row == 0 {
                 
                if isOpen[index!.section].open == true {
                    cell.homeMoreBtnImg.setImage(UIImage(named: "homeBtnMore"), for: .normal)
                    
                    let section = IndexSet.init(integer: indexPath!.section)
                    homeDetailTV.reloadSections(section, with: .fade)
                    isOpen[index!.section].open = false
                    
                }else {
                    cell.homeMoreBtnImg.setImage(UIImage(named: "homeBtnMoreClose"), for: .normal)
                    let section = IndexSet.init(integer: indexPath!.section)
                    homeDetailTV.reloadSections(section, with: .fade)
                    isOpen[index!.section].open = true
                }
            }
            
        }
    }
    
  
    
    
}
