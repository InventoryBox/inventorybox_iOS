//
//  IvHomeSideUserPostVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/23.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvHomeSideUserPostVC: UIViewController {

    @IBOutlet weak var userPostTableView: UITableView!
 
    
    var postInformations : [IvHomeUserPostInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Stuffinformation()
        userPostTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        userPostTableView.dataSource = self
        userPostTableView.delegate = self
    }

    // 뒤로가기 버튼
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 내가 쓴 게시글
    func Stuffinformation(){
        let data1 = IvHomeUserPostInformation(upload: "2020-07-16 20:00:00", exep: "2020-07-16 20:00:00", image: "homeImgProfile", name: "우유아녀", sold: 1 , price: 13000)
        
        let data2 = IvHomeUserPostInformation(upload: "2020-07-16 20:00:00", exep: "2020-07-16 20:00:00", image: "homeImgProfile", name: "아직 안팔렸지렁", sold: 0 , price: 4000)
        
        let data3 = IvHomeUserPostInformation(upload: "2020-07-16 20:00:00", exep: "2020-07-16 20:00:00", image: "homeImgProfile", name: "팔려 부렸다", sold: 1 , price: 5000)
        
        let data4 = IvHomeUserPostInformation(upload: "2020-07-16 20:00:00", exep: "2020-07-16 20:00:00", image: "homeImgProfile", name: "우유아녀", sold: 1 , price: 13000)
        
        let data5 = IvHomeUserPostInformation(upload: "2020-07-16 20:00:00", exep: "2020-07-16 20:00:00", image: "homeImgProfile", name: "아직 안팔렸지렁", sold: 0 , price: 4000)
        
        let data6 = IvHomeUserPostInformation(upload: "2020-07-16 20:00:00", exep: "2020-07-16 20:00:00", image: "homeImgProfile", name: "팔려 부렸다", sold: 1 , price: 5000)
        postInformations = [data1, data2, data3, data4, data5, data6]
    }
}

extension IvHomeSideUserPostVC: UITableViewDataSource{
    // section을 두개로 나누겠다.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // section 별 cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return postInformations.count
        }else{
            return postInformations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // section 이 0 일때 
        if indexPath.section == 0 {
        
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: IvHomeSideUserPostTVCell.identifier, for: indexPath) as? IvHomeSideUserPostTVCell else {return UITableViewCell()}
            
            // 안팔렸을 때 cell을 넣겠다!
            if postInformations[indexPath.row].isSold == 0 {
                cell1.setInformation(upload: postInformations[indexPath.row].postUploadDate, Image: postInformations[indexPath.row].postImage, Name: postInformations[indexPath.row].postName, exep: postInformations[indexPath.row].exepDate, sold: postInformations[indexPath.row].isSold, Price: postInformations[indexPath.row].postPrice)
                
                return cell1
            }else{
                return UITableViewCell()
            }
            
        }else{
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: IvHomeSideUserPostCompleteTVCell.identifier, for: indexPath) as? IvHomeSideUserPostCompleteTVCell else {return UITableViewCell()}
            
            // 팔렸을 때 cell을 넣겠다!
            if postInformations[indexPath.row].isSold == 1 {
            cell2.setInformation(upload: postInformations[indexPath.row].postUploadDate, Image: postInformations[indexPath.row].postImage, Name: postInformations[indexPath.row].postName, exep: postInformations[indexPath.row].exepDate, sold: postInformations[indexPath.row].isSold, Price: postInformations[indexPath.row].postPrice)
                
            return cell2
            }else{
                return UITableViewCell()
            }
        }
    }
    
    
    // 헤더 집어넣기
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            guard let headercell = tableView.dequeueReusableCell(withIdentifier: IvHomeSideUserPostCompleteHeaderTVCell.identifier) as? IvHomeSideUserPostCompleteHeaderTVCell else{return UITableViewCell()}
            
            return headercell
            
        }else{return nil}
    }
}

extension IvHomeSideUserPostVC: UITableViewDelegate{
    
    // cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if postInformations[indexPath.row].isSold == 0{
                return 114
            }else{
                return 0
            }
        }else{
            if postInformations[indexPath.row].isSold == 1{
                return 114
            }else{
                return 0
            }
        }
    }
    
    // 헤더 높이 설정
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
           if section == 1 {
            return 44
           }else { return 0 }
       }
    
}




