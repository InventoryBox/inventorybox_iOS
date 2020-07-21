//
//  IvExchangeSearchVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvExchangeSearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    
    var resultArray: [String] = []
    var allArray: [Address] = []
    var roadArray: [RoadAddress] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchTextFieldCustom()
        setSearchTableView()
        setShadow()
    }
    
    private func setShadow() {
        topView.layer.shadowOpacity = 0.1
        topView.layer.shadowRadius = 2
        topView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    private func setSearchTableView() {
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        searchResultTableView.allowsSelection = false
        searchResultTableView.separatorStyle = .none
    }
    
    private func setSearchTextFieldCustom() {
        
        searchTextField.delegate = self
        
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchTextField.layer.shadowRadius = 2
        searchTextField.layer.shadowOpacity = 0.16
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension IvExchangeSearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        self.view.endEditing(true)
        guard let searchQuery = textField.text else { return true }
        print(searchQuery)
        
        KaKaoLocalService.shared.getLocal(query: searchQuery, completion: { (networkResult) in
            switch networkResult {
            case .success(let data):
                
                guard let dt = data as? [Document] else {
                    return
                }
                
                
                self.resultArray = []
                self.allArray = []
                for i in dt {
                    print(i)
                    self.resultArray.append(i.addressName)
                    if let address = i.address {
                        self.allArray.append(address)
                    }
                    if let road = i.roadAddress {
                        self.roadArray.append(road)
                    }
                    
                }
                
                self.searchResultTableView.reloadData()

            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        })
        searchResultTableView.reloadData()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("begin")
    }
    
}

//MARK: - TableView

extension IvExchangeSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchCell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else { return UITableViewCell() }

        searchCell.delegate = self
        searchCell.setData(resultArray[indexPath.row])
        return searchCell
        
    }
    
}

extension IvExchangeSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: false, completion: nil)
    }
}



//MARK: - 내 주소 변경하기
extension IvExchangeSearchVC: AddressClickDelegate {
    func setAddress(addressName: String) {
        print("tap")
        
        NotificationCenter.default.post(name: .init("name"), object: nil, userInfo: ["address": addressName])
        var latitude: String = ""
        var longitude: String = ""
        for i in 0..<allArray.count {
            
            if addressName == allArray[i].addressName {
                latitude = allArray[i].x
                longitude = allArray[i].y
            }
        }
        
        for i in 0..<roadArray.count {
            if addressName == roadArray[i].addressName {
                latitude = roadArray[i].x
                longitude = roadArray[i].y
            }
        }
        
        AddressUpdateService.shared.postAddress(addressName, latitude, longitude) { (networkResult) in
            switch networkResult {
            case .success(let data):
                
                print(data)
                self.navigationController?.popViewController(animated: true)
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
        
    }
}
