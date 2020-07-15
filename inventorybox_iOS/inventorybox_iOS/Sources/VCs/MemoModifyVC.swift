//
//  MemoModifyVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class MemoModifyVC: UIViewController {
    
    private var orderCheckMemoInformations : [orderCheckMemoTVCInfo] = [ ]
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setmemoorderCheckInformations()
        
        // table
        tableview.dataSource = self
        tableview.delegate = self
        
        // tableView 안눌리게
        tableview.allowsSelection = false
        tableview.separatorStyle = .none
        tableview.contentInsetAdjustmentBehavior = .never
        
    }
    
    
    // MARK: TableView 관련 더미데이터
    private func setmemoorderCheckInformations() {
        
        let data1 = orderCheckMemoTVCInfo(productimage: "homeIcMilk.png", productname: "우유", productcount: 9999)
        let data2 = orderCheckMemoTVCInfo(productimage: "homeIcGreenpowder.png", productname: "녹차 파우더", productcount: 1)
        let data3 = orderCheckMemoTVCInfo(productimage: "homeIcStrawberry.png", productname: "딸기", productcount: 555)
        let data4 = orderCheckMemoTVCInfo(productimage: "homeIcCoffee.png", productname: "원두", productcount: 42)
        let data5 = orderCheckMemoTVCInfo(productimage: "homeIcHssyrup.png", productname: "허니 시럽", productcount: 5)
        let data6 = orderCheckMemoTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: 12)
        let data7 = orderCheckMemoTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: 12)
        
        orderCheckMemoInformations = [data1, data2, data3, data4,data5,data6,data7]
    }
    
    
    @IBAction func ModifyBackPRessBtn(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
        // 로그인 화면으로 돌아가기 위해!!
    }
}


extension MemoModifyVC: UITableViewDataSource{
    
//    // section 개수를 정의해주는 함수
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return orderCheckMemoInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //             section == 1 밑에꺼
        guard let cells = tableView.dequeueReusableCell(withIdentifier: "MemoTVCell", for: indexPath) as? MemoTVCell else { return UITableViewCell() }
        cells.SetMemoProductImformation(productImage: orderCheckMemoInformations[indexPath.row].productImage, productNameTx: orderCheckMemoInformations[indexPath.row].productName, productCountTx: orderCheckMemoInformations[indexPath.row].productCount)
        return cells
        
    }
}

    

extension MemoModifyVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
}
