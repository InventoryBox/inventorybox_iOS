//
//  AddCategoryPopupVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class AddCategoryPopupVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 9
        cancelBtn.layer.cornerRadius = 25
        addBtn.layer.cornerRadius = 25
    }

}
