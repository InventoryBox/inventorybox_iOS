//
//  IvDetailGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvDetailGraphVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var ivDetilTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //네비게이션 바 나타나게 하는 코드
        self.navigationController?.navigationBar.isHidden = false
        ivDetilTV.delegate = self
        ivDetilTV.dataSource = self

        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 3
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailGraphTVHeaderCell") as! IvDetailGraphTVHeaderCell
                
                return headerCell
            }
                
            else {
                guard let weekGraphCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailWeekGraphTVCell", for:indexPath) as? IvDetailWeekGraphTVCell else {return UITableViewCell()}
                
                
                return weekGraphCell
            }
        }
            
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvWeekCompareGraphTVCell") as! IvWeekCompareGraphTVCell
            
            return cell
            
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvEditTVCell") as! IvEditTVCell
            
            return cell
        }
    
    }
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
