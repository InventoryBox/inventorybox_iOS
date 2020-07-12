//
//  OnboardingTwoVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Lottie

class OnboardingTwoVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimationView()
        setBtnCustom()
        
    }
    @IBAction func goToNextOnboarding(_ sender: Any) {
        guard let nextOnboardingVC = self.storyboard?.instantiateViewController(identifier: "OnboardingVC")
            as? OnboardingVC  else {
                return
        }
        nextOnboardingVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(nextOnboardingVC, animated: false, completion: nil)
    }
    private func setAnimationView() {
        animationView.animation = Animation.named("26594-add-text")
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func setBtnCustom() {
        nextBtn.layer.cornerRadius = 20
        nextBtn.backgroundColor = .yellow
        nextBtn.tintColor = .white
    }
}
