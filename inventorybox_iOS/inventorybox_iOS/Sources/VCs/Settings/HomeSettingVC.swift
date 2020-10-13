//
//  HomeSettingVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/09/20.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeSettingVC: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingTitle = ["재고창고 이용약관", "개인정보처리방침", "위치기반서비스 이용약관", "재고창고 사용법"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "서비스 정보"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension HomeSettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == 3) {
            guard let detailVC = self.storyboard?.instantiateViewController(identifier: IvSettingUsageVC.identifier) as? IvSettingUsageVC else { return }
            detailVC.navigationTitle = settingTitle[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            guard let detailVC = self.storyboard?.instantiateViewController(identifier: SettingDetailVC.identifier) as? SettingDetailVC else { return }
            detailVC.navigationTitle = settingTitle[indexPath.row]
            detailVC.whichInformation = indexPath.row
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
}

extension HomeSettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UITableViewCell() }
        settingCell.set(title: settingTitle[indexPath.row])
        return settingCell
        
    }
    
}
