//
//  HomeSlideTransition.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeSlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // SideMenuBar가 띄워 졌냐 안띄워 졌냐 (presenting 되면 true . dismiss 되면 false)
    var isPresenting = false
    let dimingView = UIView()       // 사이드 바 눌렀을 떄 배경
    
    
    // 얼마의 시간동안 보여줄 것이냐?
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    // 동작을 구현하는 함수
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // ViewController의 시작과 끝의 변수 설정
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {return }
        
        let containerView = transitionContext.containerView
        
        let width = toViewController.view.bounds.width      // 오른쪽 끝에서 나와야 하므로
        
        // 화면의 크기 (위 시간이 지났을 때 마지막에 보여지는 화면 크기)
        let finalwidth = toViewController.view.bounds.width * 0.5
        let finalheight = toViewController.view.bounds.height
        
        // 띄워 졌냐 안띄워 졌냐
        if isPresenting {
            dimingView.backgroundColor = .black
            dimingView.alpha = 0.0
            containerView.addSubview(dimingView)
            dimingView.frame = containerView.bounds
            
            containerView.addSubview(toViewController.view)
            
            // 화면에서 안보이도록 하기 위해!!
            toViewController.view.frame = CGRect(x: width, y: 0, width: finalwidth, height: finalheight)
        }
        
        // 화면에 나타나는 곳
        let transform = {
            self.dimingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: -finalwidth, y: 0)
        }
        
        // 화면 사라지기 (원상 복귀)
        let identity = {
            self.dimingView.alpha = 0.0
            fromViewController.view.transform = .identity   // 원상복귀 하는 것
        }
        
        
        // animation transition
        let duration = transitionDuration(using: transitionContext)
        let iscancelled = transitionContext.transitionWasCancelled
        
        // 움직임을 주겠다!!
        // Duration의 시간동안
        UIView.animate(withDuration: duration, animations: { self.isPresenting ? transform() : identity() }) { (_) in
            transitionContext.completeTransition(!iscancelled)
        }
    }
    

    

    
    
    
}
