//
//  IvHomeSideUserPostVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvHomeSideUserPostVC: UIViewController {
    
    @IBOutlet weak var userPostTableView: UITableView!
    
    var postInformations : [UserArticle] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromServer()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userPostTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        userPostTableView.dataSource = self
        userPostTableView.delegate = self
    }
    
    // 뒤로가기 버튼
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //    //MARK: Home 데이터 받아오기
    func getDataFromServer(){
        
        IvHomeHamburgerUserArticleService.shared.getHomeUserPost { networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? UserArticleData else { return }
                
                self.postInformations = dt.result
                self.userPostTableView.reloadData()
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
                
                cell1.setInformation(upload: postInformations[indexPath.row].uploadDate, imageName: postInformations[indexPath.row].productImg, Name: postInformations[indexPath.row].productName, exep: postInformations[indexPath.row].expDate ?? "유통기한 없음", sold: postInformations[indexPath.row].isSold, Price: postInformations[indexPath.row].coverPrice)
                
                
                return cell1
            } else {
                
                return UITableViewCell()
            }
            
        }else{
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: IvHomeSideUserPostCompleteTVCell.identifier, for: indexPath) as? IvHomeSideUserPostCompleteTVCell else {return UITableViewCell()}
            
            // 팔렸을 때 cell을 넣겠다!
            if postInformations[indexPath.row].isSold == 1 {
                
                cell2.setInformation(upload: postInformations[indexPath.row].uploadDate, imageName: postInformations[indexPath.row].productImg, Name: postInformations[indexPath.row].productName, exep: postInformations[indexPath.row].expDate ?? "유통기한 없음", sold: postInformations[indexPath.row].isSold, Price: postInformations[indexPath.row].coverPrice)
                
                return cell2
            } else {
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
        // section 0 이고 안팔렸을 때
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
