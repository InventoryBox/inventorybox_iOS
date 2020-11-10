//HomeNewDetailTVCell
//  IvHomeEditVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvHomeEditVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var homeEditDetailTV: UITableView!
    
    private var orderCheckInformations : [HomeItem] = []
    var isOpen:[HomeDetailInfoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeEditDetailTV.delegate = self
        homeEditDetailTV.dataSource = self
        getDataFromServer()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "발주 확인"
        
        //tableView 선택 안되게!
        self.homeEditDetailTV.allowsSelection = false
        
        
    }
    
    
    
    @IBAction func editCompleteBtn(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
   
  
    func getDataFromServer(){
        
        HomeService.shared.getHome { networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    
                    return }
                self.orderCheckInformations = dt.result
                print(self.orderCheckInformations.count)
                
                for _ in 0...self.orderCheckInformations.count - 1 {
                    self.isOpen.append(HomeDetailInfoData(open: false))
                }
                
                DispatchQueue.main.async {
                    self.homeEditDetailTV.reloadData()
                    print(self.orderCheckInformations)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeEditTVCell", for: indexPath) as! HomeEditTVCell
            
            let url = URL(string: orderCheckInformations[indexPath.section].img)
            let data = try? Data(contentsOf: url!)
            cell.itemImageView.image = UIImage(data: data!)
            cell.itemNameLabel.text = orderCheckInformations[indexPath.section].itemName
            cell.itemCountTextField.text = String(orderCheckInformations[indexPath.section].memoCnt)
    
            cell.orderCheckInformations.append(contentsOf: self.orderCheckInformations)
            
            return cell
            
        } else {
            let cell:HomeEditContentTVCell = tableView.dequeueReusableCell(withIdentifier: "HomeEditContentTVCell", for: indexPath) as! HomeEditContentTVCell
            
            cell.removeLimitLine()
            cell.alarmCountLabel.text = "\(orderCheckInformations[indexPath.section].alarmCnt)"
            cell.bind(model: orderCheckInformations[indexPath.section])
            
           
            
            return cell
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

