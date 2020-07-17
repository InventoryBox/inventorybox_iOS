//
//  HomeVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import BEMCheckBox


class HomeVC: UIViewController {
    
    // table에 연결할 더미 데이터
    private var orderCheckInformations : [HomeItem] = [ ]
    private var height: CGFloat?
    var homeMoreViewCellHeight : CGFloat = 94       // Home2TVCell 높이
    var homeMoreViewCellPointtmemorry : Int?       // 전에 있던 위치값
    var homeMoreViewCellPoint : Int?                // 위치값 구해야 되므로
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableview: UITableView! // 전체 TableView
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromServer()     // 서버 데이터 viewdidload
    }
    // MARK: override 부분
    override func viewDidLoad() {
        super.viewDidLoad()
        // collectionview cell 높이 관련 옵져버
        NotificationCenter.default.addObserver(self, selector: #selector(setStockHeight), name: .init("notifyHeight"), object: nil)
        
        // checkbox 관련 옵져버
        NotificationCenter.default.addObserver(self, selector: #selector(selectCheckBox), name: .init("tablevalue"), object: nil)
        
        // 더보기 관련 옵져버
        NotificationCenter.default.addObserver(self, selector: #selector(morbutton), name: .init("morepressbutton"), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(getCount), name: .init("textmodify"), object: nil)
//
        
        // table관련 데이터
//        setorderCheckInformations()
        
        // table
        tableview.dataSource = self
        tableview.delegate = self
        
        // tableView 안눌리게
        tableview.allowsSelection = false
        tableview.separatorStyle = .none
        tableview.contentInsetAdjustmentBehavior = .never
        
        setPopupBackgroundView()
      
    }
    
     //MARK: Home 데이터 받아오기
     func getDataFromServer(){
         
         HomeService.shared.getHome(completion: { networkResult in
             switch networkResult{
             case .success(let data):
//                 print(data)
                 guard let dt = data as? HomeItemclass else { return }
                 self.orderCheckInformations = dt.result
                 self.tableview.reloadData()
             case .requestErr(let message):
                 guard let message = message as? String else {return}
                 print(message)
             case .serverErr: print("serverErr")
             case .pathErr:
                 print("pathErr")
             case .networkFail:
                 print("networkFail")
             }
         })
     }
    
    
    
    // 더보기 버튼 관련 objc
    @objc func morbutton(_ notification: Notification){
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let moreValue = userInfo["bool"] as? Bool else { return }
        guard let ivName = userInfo["name"] as? String else { return }
        
        for i in 0..<orderCheckInformations.count{
            if orderCheckInformations[i].itemName == ivName{
                homeMoreViewCellPoint = i
                if moreValue == true{
                    homeMoreViewCellHeight = 196
                }else{
                    homeMoreViewCellHeight = 94
                }
            }
        }
        tableview.reloadData()      // 데이터를 다시 불러오겠다
    }
    
    // 체크박스 관련 objc
    @objc func selectCheckBox(_ notification: Notification){
        //        print("return ")
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let checkvalue = userInfo["bool"] as? Bool else { return }
        guard let ivName = userInfo["name"] as? String else { return }
        guard let indexPath = userInfo["indexPath"] as? Int else { return }
        guard let isSelect = userInfo["isSelect"] as? Int else { return }
        orderCheckInformations[indexPath].flag = isSelect
        
        NotificationCenter.default.post(name: .init("checklist"), object: nil, userInfo: ["bool": checkvalue, "name": ivName])
        
    }
    
    
    
    // MARK: sideBar 눌렀을때 배경화면 설정하기 위한 setting
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    func showSettings(animated: Bool) {
        let vc = SideMenuVC()
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
    
    
    
    
    
    @objc func setStockHeight(_ notification: NSNotification) {
        
        guard let height = notification.userInfo?["cvheight"] as? CGFloat else { return }
        self.height = height
//        print(height)
        
        tableview.reloadData()
    }
    private func setPopupBackgroundView() {
        
        backgroundView.isHidden = true
        backgroundView.alpha = 0
        self.view.bringSubviewToFront(backgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {

        self.tabBarController?.tabBar.isHidden = false
        animatePopupBackground(false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.backgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.backgroundView.alpha = alpha
        }
        
    }
    // @@@@@@@@@@@@@@@
    // sideMenuBtnPress 했을 때 발생하는 Action
    @IBAction func sideMenuPress(_ sender: Any) {
        
        guard let reciveViewController = self.storyboard?.instantiateViewController(identifier: "SideMenuVC") else { return  }
        // 다음 화면으로 넘어가고 싶은 StoryBoard의 identity -> Storyboard ID 를 변수 설정
        
        animatePopupBackground(true)
        self.tabBarController?.tabBar.isHidden = true
        
//        self.view.bringSubviewToFront(backgroundView)
        reciveViewController.modalPresentationStyle = .overCurrentContext
        // 다음에 나오는 화면을 전체 화면으로 보여 주겠다!
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//        view.window!.layer.add(transition, forKey: kCATransition)
//        view.layer.add(transition, forKey: kCATransition)
        self.present(reciveViewController, animated: true, completion: nil)
        // 화면을 보여주겠다
    }
    
    @IBAction func MemoModifyPressBtn(_ sender: Any) {
        
        guard let MemoreciveViewController = self.storyboard?.instantiateViewController(identifier: "MemoModifyVC") else { return  }
        // 다음 화면으로 넘어가고 싶은 StoryBoard의 identity -> Storyboard ID 를 변수 설정
        
        MemoreciveViewController.modalPresentationStyle = .fullScreen
        // 다음에 나오는 화면을 전체 화면으로 보여 주겠다!
        
        self.present(MemoreciveViewController, animated: true, completion: nil)
        // 화면을 보여주겠다
    }
    // @@@@@@@@@@@
    
//    // MARK: TableView 관련 더미데이터
//    private func setorderCheckInformations() {
//
//        let data1 = orderCheckTVCInfo(productimage: "homeIcMilk.png", productname: "우유", productcount: 9999, productset: "덩어리")
//        let data2 = orderCheckTVCInfo(productimage: "homeIcGreenpowder.png", productname: "녹차 파우더", productcount: 1, productset: "팩")
//        let data3 = orderCheckTVCInfo(productimage: "homeIcStrawberry.png", productname: "딸기", productcount: 555, productset: "개")
//        let data4 = orderCheckTVCInfo(productimage: "homeIcCoffee.png", productname: "원두", productcount: 42, productset: "팩")
//        let data5 = orderCheckTVCInfo(productimage: "homeIcHssyrup.png", productname: "허니 시럽", productcount: 5, productset: "병")
//        let data6 = orderCheckTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: 12, productset: "팩")
//        let data7 = orderCheckTVCInfo(productimage: "homeIcMcpowder.png", productname: "모카 파우더", productcount: 12, productset: "팩")
//
//        orderCheckInformations = [data1, data2, data3, data4,data5,data6,data7]
//    }
//
    
}


// MARK: UITableViewDataSource 관련 코드
extension HomeVC: UITableViewDataSource{
    
    // section 개수를 정의해주는 함수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //         각 section에 맞게
        if section == 0{
            return 2
        }else{
//            print(orderCheckInformations)
            return orderCheckInformations.count
        }
    }
    
    
    // MARK: UITableViewDelegate 관련 코드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // section == 0 위에꺼
        if indexPath.section == 0{
            
            if indexPath.row == 0{
                // header1
                guard let headerCell1 = tableView.dequeueReusableCell(withIdentifier: "HomeHeader1TVCell", for: indexPath) as? HomeHeader1TVCell else { return UITableViewCell() }
                
                return headerCell1
                
            }else{
                // tableviewcell2 -> collectionviewcell
                guard let Cell1s = tableView.dequeueReusableCell(withIdentifier: "Home1TVCell", for: indexPath) as? Home1TVCell else { return UITableViewCell() }
                
                return Cell1s
            }
            
        }else{
            //             section == 1 밑에꺼
            guard let Cell2s = tableView.dequeueReusableCell(withIdentifier: "Home2TVCell", for: indexPath) as? Home2TVCell else { return UITableViewCell() }
            
            // cell 재사용 문제 해결
            Cell2s.itemIdx = orderCheckInformations[indexPath.row].itemIdx
            Cell2s.indexPath = indexPath.row
            
            Cell2s.SetProductImformation(productImage: orderCheckInformations[indexPath.row].img, productNameTx: orderCheckInformations[indexPath.row].itemName, productCountTx: orderCheckInformations[indexPath.row].memoCnt, productSetTx: orderCheckInformations[indexPath.row].unit, checkFlag: orderCheckInformations[indexPath.row].flag)

            return Cell2s
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHeader2TVCell") as? HomeHeader2TVCell else { return UICollectionViewCell() }
            return headerCell
        } else { return nil }
    }
}


extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                return 44
            }
            else {
                // collection view height에 맞게 변화
                guard let height = self.height else { return 0 }
                
                return UITableView.automaticDimension
            }
            
        }else{
            // tableview 높이
            if indexPath.row == homeMoreViewCellPoint {
                // row가 homeMoreViewCellPoint 일 때
//                homeMoreViewCellPointtmemorry = homeMoreViewCellPoint
                return homeMoreViewCellHeight
            }
//            else if indexPath.row == homeMoreViewCellPointtmemorry{
//                return homeMoreViewCellHeight
//
//            }
        else{
            return 94
        }
    }
}
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 { return 44 }
        else { return 0 }
    }
}



extension HomeVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}

class RightToLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.25
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        container.addSubview(toView)
        toView.frame.origin = CGPoint(x: toView.frame.width, y: 0)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            toView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class LeftToRightTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.25
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        container.addSubview(fromView)
        fromView.frame.origin = .zero
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            fromView.frame.origin = CGPoint(x: fromView.frame.width, y: 0)
        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
