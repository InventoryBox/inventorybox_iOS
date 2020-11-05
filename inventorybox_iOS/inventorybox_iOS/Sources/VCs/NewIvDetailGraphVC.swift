//
//  NewIvDetailGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class NewIvDetailGraphVC: UIViewController{
    
    
    @IBOutlet var ivDetailGraphTV: UITableView!
    var itemName:String?
    var itemIdx:Int? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivDetailGraphTV.delegate = self
        ivDetailGraphTV.dataSource = self
        
    }
    
    
    
    
}
extension NewIvDetailGraphVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            
        }
        else if section == 1 {
            return 1
        }
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "NewIvGraphDetailTableHeaderCell") as! NewIvGraphDetailTableHeaderCell
                
                headerCell.itemIdx = itemIdx!
                
                
                
                return headerCell
            }
            
            else {
                guard let weekGraphCell = tableView.dequeueReusableCell(withIdentifier: "NewDetailWeekInfoTVCell", for:indexPath) as? NewDetailWeekInfoTVCell else {return UITableViewCell()}
                
                
                
                return weekGraphCell
            }
        }
        
        
        else if indexPath.section == 1 {
            let IvWeekCompareGraphTVCell = tableView.dequeueReusableCell(withIdentifier: "NewCompareGraphTVCell") as! NewCompareGraphTVCell
            
            
            
            
            
            return IvWeekCompareGraphTVCell
            
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvEditTVCell") as! IvEditTVCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 79
            }
            else {
                return 185
            }
        }
        
        if indexPath.section == 1 {
            return 319
        }
        
        return 160
        
    }
    
    
}
