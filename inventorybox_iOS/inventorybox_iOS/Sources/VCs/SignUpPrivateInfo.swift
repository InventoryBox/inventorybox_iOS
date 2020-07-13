//
//  SignUpPrivateInfo.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SignUpPrivateInfo: UIViewController {

    @IBOutlet var signUpSecondProgressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpSecondProgressBar.progress = 0.5
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
