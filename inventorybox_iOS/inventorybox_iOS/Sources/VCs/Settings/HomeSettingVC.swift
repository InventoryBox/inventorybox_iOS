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
    @IBOutlet weak var popupBackgroundView: UIView!
    
    let settingTitle = ["자주 묻는 질문", "서비스 정보", "로그아웃"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        settingTableView.delegate = self
        settingTableView.dataSource = self
        setPopupBackgroundView()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
    }
    
    
    func animatePopupBackground(_ direction: Bool) {
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        self.navigationController?.navigationBar.isHidden = direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
    }
    
    @IBAction func userOutPopUP(_ sender: UIButton) {
        
        animatePopupBackground(true)
        guard let vc = self.storyboard?.instantiateViewController(identifier: "UserOutPopUpVC") else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
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
        
        if (indexPath.row == 0) {
            guard let detailVC = self.storyboard?.instantiateViewController(identifier: IvSettingUsageVC.identifier) as? IvSettingUsageVC else { return }
            detailVC.navigationTitle = settingTitle[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else if indexPath.row == 1 {
            
            guard let detailVC = self.storyboard?.instantiateViewController(identifier: "QuestionVC") as? QuestionVC else { return }
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            animatePopupBackground(true)
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "LogOutPopUpVC") else { return }
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false)
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
