//
//  OnboardingVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Lottie

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnCustom()
        setAnimationView()
        
    }
    
    @IBAction func goToIvRecord(_ sender: Any) {
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        guard let tabBarVC = main.instantiateViewController(identifier: "TabBarVC")
            as? TabBarVC  else {
                return
        }
        tabBarVC.modalPresentationStyle = .fullScreen
        
        self.present(tabBarVC, animated: false, completion: nil)
    }
    
    private func setAnimationView() {
        animationView.animation = Animation.named("hamburger")
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func setBtnCustom() {
        startBtn.layer.cornerRadius = 20
        startBtn.backgroundColor = .yellow
        startBtn.tintColor = .white
    }
}
