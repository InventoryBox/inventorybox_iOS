//
//  IvHomeEditVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvHomeEditVC: UIViewController {


    @IBOutlet var homeDetailTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editCompleteBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false)
    }
    
    

}
