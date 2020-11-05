//
//  HomeNewDetailVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class HomeNewDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var homeDetailTV: UITableView!
    private var orderCheckInformations : [HomeItem] = []
    var isOpen:[HomeDetailInfoData] = []
    var flagInt:[HomeDetailInfoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeDetailTV.delegate = self
        homeDetailTV.dataSource = self
        getDataFromServer()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "발주 확인"
        self.homeDetailTV.allowsSelection = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromServerLater()
    }
    
  
    func getDataFromServer(){
        
        HomeService.shared.getHome { [self] networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    
                    return }
                self.orderCheckInformations = dt.result
                print(self.orderCheckInformations.count)
                
                for i in 0...self.orderCheckInformations.count - 1 {
                    self.isOpen.append(HomeDetailInfoData(open: false, flagInt: orderCheckInformations[i].flag))
                    
                }
                
                DispatchQueue.main.async {
                    self.homeDetailTV.reloadData()
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
    func getDataFromServerLater(){
        
        HomeService.shared.getHome { [self] networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    
                    return }
                self.orderCheckInformations = dt.result
                print(self.orderCheckInformations.count)
            
                
                DispatchQueue.main.async {
                    self.homeDetailTV.reloadData()
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
    
  
        
        
    
    @IBAction func memoEditBarClick(_ sender: UIBarButtonItem) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "editIvHome") as? IvHomeEditVC else {return}
        self.navigationController?.pushViewController(dvc, animated: false)
    }
    
    @IBAction func memoBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return orderCheckInformations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isOpen[section].open == true {
            return 1 + 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 94
        }else{
            return 94
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewDetailTVCell", for: indexPath) as! HomeNewDetailTVCell
            
            let url = URL(string: orderCheckInformations[indexPath.section].img)
            let data = try? Data(contentsOf: url!)
            cell.itemImg.image = UIImage(data: data!)
            cell.itemNameLabel.text = orderCheckInformations[indexPath.section].itemName
            cell.itemMemoCountLabel.text = String(orderCheckInformations[indexPath.section].memoCnt)
            cell.itemUnitLabel.text = orderCheckInformations[indexPath.section].unit
            
            cell.itemIndex = orderCheckInformations[indexPath.section].itemIdx
            
            
            
            if orderCheckInformations[indexPath.section].flag == 1 {
                cell.itemFlagBtn.setImage(UIImage(named: "homeBtnCheckSelect"), for: .normal)
            } else {
                cell.itemFlagBtn.setImage(UIImage(named: "homeBtnCheckUnselect"), for: .normal)
            }
            
            return cell
            
        } else {
            let cell:HomeNewDetailContentTVCell = tableView.dequeueReusableCell(withIdentifier: "HomeNewDetailContentTVCell", for: indexPath) as! HomeNewDetailContentTVCell
            
            cell.removeLimitLine()
            cell.alarmCntLabel.text = "\(orderCheckInformations[indexPath.section].alarmCnt)"
            cell.bind(model: orderCheckInformations[indexPath.section])
            
            return cell
        }
    }

    
    @IBAction func moreSectionBtn(_ sender: UIButton) {
        
        getDataFromServerLater()
        
        let cell = sender.superview?.superview as! HomeNewDetailTVCell
        let index = self.homeDetailTV.indexPath(for: cell)
        var indexPath : IndexPath? = nil
        indexPath = homeDetailTV.indexPathForRow(at: homeDetailTV.convert(sender.center, from: sender.superview))

        if index!.row == index!.row {
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
    
   
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
}
