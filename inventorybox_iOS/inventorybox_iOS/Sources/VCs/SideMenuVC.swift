//
//  SideMenuVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 뒤로가기 버튼
    @IBAction func btnClickBack(_ sender: Any) {
        
        NotificationCenter.default.post(name: .init("popup"), object: nil)
        self.dismiss(animated: true, completion: nil)
          // 로그인 화면으로 돌아가기 위해!!
    }
    
    @IBAction func alarmPresBtn(_ sender: Any) {
        
        guard let reciveViewController = self.storyboard?.instantiateViewController(identifier: "SideBarMenuAlramVC") else { return  }
        // 다음 화면으로 넘어가고 싶은 StoryBoard의 identity -> Storyboard ID 를 변수 설정
        
        reciveViewController.modalPresentationStyle = .fullScreen
        // 다음에 나오는 화면을 전체 화면으로 보여 주겠다!
        
        self.present(reciveViewController, animated: true, completion: nil)
        // 화면을 보여주겠다

    }
    
    @IBAction func profilePressBtn(_ sender: Any) {
        
        guard let reciveViewController = self.storyboard?.instantiateViewController(identifier: "SideBarMenuPrifileVC") else { return  }
        // 다음 화면으로 넘어가고 싶은 StoryBoard의 identity -> Storyboard ID 를 변수 설정
        
        reciveViewController.modalPresentationStyle = .fullScreen
        // 다음에 나오는 화면을 전체 화면으로 보여 주겠다!
        
        self.present(reciveViewController, animated: true, completion: nil)
        // 화면을 보여주겠다
        
        
    }
    
    @IBAction func privacyPressBtn(_ sender: Any) {
        
        guard let reciveViewController = self.storyboard?.instantiateViewController(identifier: "SideBarMenuPrivacyVC") else { return  }
        // 다음 화면으로 넘어가고 싶은 StoryBoard의 identity -> Storyboard ID 를 변수 설정
        
        reciveViewController.modalPresentationStyle = .fullScreen
        // 다음에 나오는 화면을 전체 화면으로 보여 주겠다!
        
        self.present(reciveViewController, animated: true, completion: nil)
        // 화면을 보여주겠다
        
    }
    
}
