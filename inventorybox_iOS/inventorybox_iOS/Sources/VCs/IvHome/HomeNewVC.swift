//
//  HomeNewVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/08/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class HomeNewVC: UIViewController {

    @IBOutlet weak var homeListCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var detailButton: UIView!
    @IBOutlet weak var CurentTime: UILabel!     // 현재 시간
    @IBOutlet var goToHomeDetailBtn: UIButton!
    
    var page : Int = 0 {didSet{}}     // page 개수 관련 변수
    var curentpage : Int = 0
    
    var flagInt:[Int] = [] {didSet{print("flagInt잘 들어갔나?\(flagInt)")}}

    var leftFlagInt:[Int] = [] {didSet{print("왼쪽 flagInt잘 들어갔나?\(leftFlagInt)")}}  // flag값
    var rightFlagInt:[Int] = [] {didSet{print("오른쪽 flagInt잘 들어갔나?\(rightFlagInt)")}}  // flag값

    
    var leftValue = 0 {didSet{print("왼쪽 \(leftValue)")}}        // 몫 값
    var leftRemainder = 0 {didSet{}}    // 나머지 값
    var rigntValue = 0 {didSet{print("오른쪽 \(rigntValue)")}}        // 몫 값
    var rigntRemainder = 0 {didSet{}}    // 나머지 값
    
    // 사이드바 만든거 사용하기 위해
    let transition = HomeSlideTransition()

    // 실 데이터
    private var checkOrderInfo : [HomeItem] = []{didSet{}}
    private var leftCheckOrderInfo : [HomeItem] = []{didSet{}}
    private var rightCheckOrderInfo : [HomeItem] = []{didSet{}}
    
    //test를 위한 더미 데이터 배열
//    private var customData: [DataModel] = []
//    private var customLeftData : [DataModel] = []
//    private var customRightData : [DataModel] = []

    override func viewWillAppear(_ animated: Bool) {
        getDataFromServer()
        homeListCollectionView.dataSource = self
        homeListCollectionView.delegate = self
        setimage()
        NotificationCenter.default.addObserver(self, selector: #selector(allflag), name: .init("allflage"), object: nil)

        self.homeListCollectionView.reloadData()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        goToHomeDetailBtn.layer.cornerRadius = 20
        makeShadowUnderView()   // 그림자 & Radious
        date()
        pages()

        self.navigationController?.navigationBar.isHidden = true
    }

    // 날짜정보 입력하기
    func date(){
        let formater_year = DateFormatter()
        let formater_month = DateFormatter()
        let formater_day = DateFormatter()
        let formater_date = DateFormatter()
        formater_date.locale = Locale(identifier: "ko")
        
        formater_year.dateFormat = "yyyy"
        formater_month.dateFormat = "MM"
        formater_date.dateFormat = "eeee"
        formater_day.dateFormat = "dd"
        let current_day_String = formater_day.string(from: Date())
        let current_month_String = formater_month.string(from: Date())
        let current_year_String = formater_year.string(from: Date())
        let current_date_String = formater_date.string(from: Date())
        

        CurentTime.text = "\(current_year_String).\(current_month_String).\(current_day_String) \(current_date_String)"
    }
    
    // 체크박스 관련 objc
        @objc func allflag(_ notification: Notification){
            guard let userInfo = notification.userInfo as? [String: Any] else { return }
            guard let allflage = userInfo["all"] as? Array<Int> else { return }
            
            self.flagInt = allflage
            print ("진짜 잘받아 왔으면 좋겠다야\(self.flagInt)")
        }

    
    func setimage(){

            for i in 0..<self.flagInt.count {
                if i%2 == 0{
                    self.leftFlagInt.append(self.flagInt[i])
                }else{
                    self.rightFlagInt.append(self.flagInt[i])
                }
            }
    }
    
    func onOff(flagInt : Int) -> String{

        print("onoff 됐니?? 확실히?")

        if flagInt == 1{
            let on : String = "homeIcAble"
            print("on 됐어")
            return on
        }else if flagInt == 0{
            let off : String = "homeIcUnable"
            print("off 됐어")
            return off
        }else{
            let aaa : String = "24"
            return aaa
        }
    }
    
    @IBAction func detailPressBtn(_ sender: Any) {
        guard let detailNVC = storyboard?.instantiateViewController(identifier: "DetailNVC") as? DetailNVC else {return}
        
        detailNVC.modalPresentationStyle = .fullScreen
        present(detailNVC, animated: true, completion: nil)
    }
    
    // MARK: sideMenuBar 눌렀을 떄 행동
    @IBAction func sideMenuBarAction(_ sender: Any) {
        guard let sideMenuBarVC = storyboard?.instantiateViewController(withIdentifier: "HomeNewSideMenuVC") as? HomeNewSideMenuVC else {return }
        
        sideMenuBarVC.didTapMenuType = {menuType in
            self.transtionToNew(menuType)
            // print(menuType)
        }
        sideMenuBarVC.modalPresentationStyle = .overCurrentContext
        sideMenuBarVC.transitioningDelegate = self
        
        present(sideMenuBarVC, animated: true)
        
        // MARK: 회색 처리된 배경 누르면 dismiss 되게 만들기
        let tap = UITapGestureRecognizer(target: self, action:    #selector(self.handleTap(_:)))
        // dimingView(gray 배경)에 (tap)제스쳐를 입히겠다
        transition.dimingView.addGestureRecognizer(tap)
    }
    
    func transtionToNew(_ menuType : MenuType){
        
        switch menuType{
        
        // 프로필 변경
        case .profile:
            guard let profileVC = self.storyboard?.instantiateViewController(identifier: "HomeSideProfileVC") as? HomeSideProfileVC else {return}
            
            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: true, completion: nil)
            
        // 개인 정보 변경
        case .myInfo:
            guard let myInfoVC = self.storyboard?.instantiateViewController(identifier: "MyInfoNC") as? MyInfoNC else {return}
            
            myInfoVC.modalPresentationStyle = .fullScreen
            self.present(myInfoVC, animated: true, completion: nil)
            
        // 내가 쓴 게시글
        case .post:
            guard let userPostVC = self.storyboard?.instantiateViewController(identifier: "IvHomeSideUserPostVC") as? IvHomeSideUserPostVC else { return }
            
            userPostVC.modalPresentationStyle = .fullScreen
            self.present(userPostVC, animated: true, completion: nil)
            
        // 비밀번호 변경
        case .change:
            guard let passwordChangeVC = self.storyboard?.instantiateViewController(identifier: "HomeSidePasswordChangeVC") as? HomeSidePasswordChangeVC else { return }
            
            passwordChangeVC.modalPresentationStyle = .fullScreen
            self.present(passwordChangeVC, animated: true, completion: nil)
            
        // 설정
        case .setting:
            let settingStoryboard = UIStoryboard.init(name: "HomeSetting", bundle: nil)
            
            guard let settingVC = settingStoryboard.instantiateViewController(identifier: "HomeSettingNC") as? HomeSettingNC else { return  }
            settingVC.modalPresentationStyle = .fullScreen
            
            self.present(settingVC, animated: true, completion: nil)
        }
        
    }
    
    // objc 함수를 통해 행동을 정의
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func getDataFromServer(){
        
        HomeService.shared.getHome { networkResult in
            switch networkResult{
            case .success(let data):
                guard let dt = data as? HomeItemclass else {
                    return }
                self.checkOrderInfo = dt.result
                self.flagInt = []
                self.leftFlagInt = []   // flag값
                self.rightFlagInt = []   // flag값
                self.leftCheckOrderInfo = []
                self.rightCheckOrderInfo = []
                for i in 0..<self.checkOrderInfo.count {
                    // flag값 받아오기
                    self.flagInt.append(self.checkOrderInfo[i].flag)
                    print("지금 \(i)번째 값은\(self.flagInt[i])")
                }
                for i in 0..<self.checkOrderInfo.count {
                    if i % 2 == 0 {
                        //checkOrderInfo배열 중 인덱스가 짝수인 배열을 leftCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[0],checkOrderInfo[2],checkOrderInfo[4],checkOrderInfo[6] ... 번째 인덱스 즉 왼쪽 CV에 나타날 정보들
                        self.leftCheckOrderInfo.append(self.checkOrderInfo[i])
                        self.leftFlagInt.append(self.flagInt[i])
                        
                    }
                    else if i % 2 == 1 {
                        //checkOrderInfo배열 중 인덱스가 홀수인 배열을 rightCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[1],checkOrderInfo[3],checkOrderInfo[5],checkOrderInfo[7] ... 번째 인덱스 즉 오른쪽 CV에 나타날 정보들
                        self.rightCheckOrderInfo.append(self.checkOrderInfo[i])
                        self.rightFlagInt.append(self.flagInt[i])
                    }else{
                    }
                }
                for i in 0..<self.leftCheckOrderInfo.count{
                    print("값은 받아옴?\(self.leftCheckOrderInfo[i].itemName)")
                }
                self.page = 1 + self.checkOrderInfo.count / 15         // 14로 나눴을 때
                self.pageControl.numberOfPages = self.page    // pagecontrol의 점 개수
                
                self.leftValue = self.leftCheckOrderInfo.count/8      // 8로 나눴을때 몫
                self.leftRemainder = self.leftCheckOrderInfo.count%7  // 8로 나눴을때 나머지
                self.rigntValue = self.rightCheckOrderInfo.count/8    //
                self.rigntRemainder = self.rightCheckOrderInfo.count%7    //
                
                // 리로드 해줘야 된다!! 꼮 명심하자!!
                DispatchQueue.main.async {
                    self.homeListCollectionView.reloadData()
                }
                
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    //    func setData(){
    //
    //        let cell1 = DataModel(salesName: "응")
    //        let cell2 = DataModel(salesName: "g")
    //        let cell3 = DataModel(salesName: "f")
    //        let cell4 = DataModel(salesName: "ff")
    //        let cell5 = DataModel(salesName: "ss")
    //        let cell6 = DataModel(salesName: "고기")
    //        let cell7 = DataModel(salesName: "고기")
    //        let cell8 = DataModel(salesName: "우유")
    //        let cell9 = DataModel(salesName: "빵")
    //        let cell10 = DataModel(salesName: "맘마")
    //        let cell11 = DataModel(salesName: "녹차")
    //        let cell12 = DataModel(salesName: "크림")
    //        let cell13 = DataModel(salesName: "파스타")
    //        let cell14 = DataModel(salesName: "kk")
    //        let cell15 = DataModel(salesName: "멍멍이")
    //        let cell16 = DataModel(salesName: "pp")
    //        let cell17 = DataModel(salesName: "바보")
    //        let cell18 = DataModel(salesName: "oo")
    //        let cell19 = DataModel(salesName: "강아지")
    //        let cell20 = DataModel(salesName: "kk")
    //        let cell21 = DataModel(salesName: "헤헤")
    //        let cell22 = DataModel(salesName: "kk")
    //        let cell23 = DataModel(salesName: "호호")
    //        let cell24 = DataModel(salesName: "kk")
    //        let cell25 = DataModel(salesName: "히히")
    //        let cell26 = DataModel(salesName: "kk")
    //        let cell27 = DataModel(salesName: "kk")
    //        let cell28 = DataModel(salesName: "kk")
    //        let cell29 = DataModel(salesName: "kk")
    //        let cell30 = DataModel(salesName: "kk")
    //
    //
    //        customData = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10,cell11,cell12,cell13,cell14,cell15,cell16,cell17,cell18,cell19,cell20,cell21,cell22,cell23,cell24,cell25,cell26,cell27,cell28,cell29,cell30]
    //
    //        for i in 0...self.customData.count - 1 {
    //            if i % 2 == 0 {
    //                //checkOrderInfo배열 중 인덱스가 짝수인 배열을 leftCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[0],checkOrderInfo[2],checkOrderInfo[4],checkOrderInfo[6] ... 번째 인덱스 즉 왼쪽 CV에 나타날 정보들
    //                self.customLeftData.append(self.customData[i])
    //            }
    //            else {
    //                //checkOrderInfo배열 중 인덱스가 홀수인 배열을 rightCheckOrderInfo배열에 따로 저장 == > checkOrderInfo[1],checkOrderInfo[3],checkOrderInfo[5],checkOrderInfo[7] ... 번째 인덱스 즉 오른쪽 CV에 나타날 정보들
    //                self.customRightData.append(self.customData[i])
    //            }
    //        }
    //
    //        leftValue = customLeftData.count/7      // 7로 나눴을때 몫
    //        leftRemainder = customLeftData.count%7  // 7로 나눴을때 나머지
    //        rigntValue = customRightData.count/7    //
    //        rigntRemainder = customRightData.count%7    //
    //
    //   }
    
    // page controller
    func pages() {
        homeListCollectionView?.isPagingEnabled = true
    }
    
    // 그림자주는 코드
    private func makeShadowUnderView() {
        
        homeListCollectionView.layer.cornerRadius = 20
        homeListCollectionView.layer.shadowRadius = 40
        homeListCollectionView.layer.shadowOpacity = 0.3
        homeListCollectionView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        detailButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        detailButton.layer.cornerRadius = 10
        detailButton.layer.shadowOpacity = 0.1
        detailButton.layer.shadowRadius = 8// 퍼지는 정도
        detailButton.layer.cornerRadius = 14
    }
}


// MARK: UICollectionView DataSource
extension HomeNewVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return page
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeNewCVCell", for: indexPath) as? HomeNewCVCell else {return UICollectionViewCell() }
        
        // 왼쪽 값 , 페이지가 하나일 떄
        if leftValue == 0{
            print("잘 진짜 들어 왔어?\(leftRemainder)")
            // 나머지에 관하여 왼쪽 값
            if indexPath.item == leftValue{
                // leftRemainder가 0일경우 " " c처리
                if leftRemainder == 0{
                    // 그 이후 나오지 말아야 하는 값들
                    for i in leftRemainder..<7 {
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = "\(self.leftCheckOrderInfo[i].itemName)"
                            listCell.leftStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[i]))")
                        }
                    }
                }else if leftRemainder == 0 && leftValue == 0{
                    print("잘 진짜 들어 왔어?\(leftRemainder)")
                    for i in 0..<leftRemainder+1{
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = "\(self.leftCheckOrderInfo[i].itemName)"
                            listCell.leftStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[i]))")
                        }
                    }
                }else{
                    for i in 0..<leftRemainder{
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = "\(self.leftCheckOrderInfo[i].itemName)"
                            listCell.leftStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[i]))")
                        }
                    }
                    // 그 이후 나오지 말아야 하는 값들
                    for i in leftRemainder..<7 {
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = " "
                            listCell.leftStackImage[i].image = UIImage(named: "homeIcCheck")
                        }
                    }
                }
            }
        }else{
            // 왼쪽 페이지 수 맞춰서 값을 넣음
            for i in 0..<leftValue{
                if indexPath.item == i{
                    switch i{
                    case 0:
                        for j in 0..<7{
                            if listCell.leftStackview[j].tag == j+1{
                                listCell.leftStackview[j].text = "\(self.leftCheckOrderInfo[j].itemName)"
                                listCell.leftStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[j]))")
                            }
                        }
                    case 1:
                        for j in 0..<7{
                            if listCell.leftStackview[j].tag == j+1{
                                listCell.leftStackview[j].text = "\( self.leftCheckOrderInfo[j+7].itemName)"
                                listCell.leftStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[j+7]))")
                            }
                        }
                    case 2:
                        for j in 0..<7{
                            if listCell.leftStackview[j].tag == j+1{
                                listCell.leftStackview[j].text = "\( self.leftCheckOrderInfo[j+14].itemName)"
                                listCell.leftStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[j+14]))")
                            }
                        }
                    case 3:
                        for j in 0..<7{
                            if listCell.leftStackview[j].tag == j+1{
                                listCell.leftStackview[j].text = "\( self.leftCheckOrderInfo[j+21].itemName)"
                                listCell.leftStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[j+21]))")
                            }
                        }
                    case 4:
                        for j in 0..<7{
                            if listCell.leftStackview[j].tag == j+1{
                                listCell.leftStackview[j].text = "\( self.leftCheckOrderInfo[j+28].itemName)"
                                listCell.leftStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[j+28]))")
                            }
                        }
                    default: break
                    }
                }
            }
            print("너 뭐야\(leftRemainder)")
            if indexPath.item == leftValue{
                print("여기 나오나요??")
                // leftRemainder가 0일경우 " " c처리
                if leftRemainder == 0{
                    // 그 이후 나오지 말아야 하는 값들
                    for i in leftRemainder..<7 {
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = " "
                            listCell.leftStackImage[i].image = UIImage(named: "homeIcCheck")
                        }
                    }
                }else if leftRemainder == 6{
                    for i in 0..<leftRemainder+1{
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = "\(self.leftCheckOrderInfo[i+((leftValue)*7)].itemName)"
                            listCell.leftStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[i+((leftValue)*7)]))")
                        }
                    }
                }else{
                    for i in 0..<leftRemainder{
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = "\(self.leftCheckOrderInfo[i+((leftValue)*7)].itemName)"
                            listCell.leftStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.leftFlagInt[i+((leftValue)*7)]))")
                        }
                    }
                    // 그 이후 나오지 말아야 하는 값들
                    for i in leftRemainder..<7 {
                        if listCell.leftStackview[i].tag == i+1 && listCell.leftStackImage[i].tag == i+1 {
                            listCell.leftStackview[i].text = " "
                            listCell.leftStackImage[i].image = UIImage(named: "homeIcCheck")
                        }
                    }
                }
            }
        }
 
        
        // 오른쪽 값, page가 하나일 때
        if rigntValue == 0 {
            
            // 나머지에 관하여 오른쪽 값
            if indexPath.item == rigntValue{
                // rightReminder가 0일경우
                if rigntRemainder == 0 {
                    for i in rigntRemainder..<7 {
                        if listCell.rigntStackView[i].tag == i+1 && listCell.rigntStackImage[i].tag == i+1 {
                            listCell.rigntStackView[i].text = "\(self.rightCheckOrderInfo[i].itemName)"
                            listCell.rigntStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[i]))")
                        }
                    }
                }else if rigntRemainder == 0 && rigntValue == 0{
                    for i in 0..<rigntRemainder+1{
                        if listCell.rigntStackView[i].tag == i+1 {
                            listCell.rigntStackView[i].text = "\(self.rightCheckOrderInfo[i].itemName)"
                            listCell.rigntStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[i]))")
                        }
                    }
                }else{
                    // 나머지 값에 관해서
                    for i in 0..<rigntRemainder{
                        if listCell.rigntStackView[i].tag == i+1 {
                            listCell.rigntStackView[i].text = "\(self.rightCheckOrderInfo[i].itemName)"
                            listCell.rigntStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[i]))")
                        }
                    }
                    
                    for i in rigntRemainder..<7 {
                        if listCell.rigntStackView[i].tag == i+1 && listCell.rigntStackImage[i].tag == i+1 {
                            listCell.rigntStackView[i].text = " "
                            listCell.rigntStackImage[i].image = UIImage(named: "homeIcCheck")
                        }
                    }
                }
            }else{
                // 문제의 구간이 여기다!!!
                for i in rigntRemainder..<7 {
                    if listCell.rigntStackView[i].tag == i+1 && listCell.rigntStackImage[i].tag == i+1 {
                        listCell.rigntStackView[i].text = " "
                        listCell.rigntStackImage[i].image = UIImage(named: "homeIcCheck")
                    }
                }
            }
        }else{
                // 오른쪽 Stack관련
                for i in 0..<rigntValue{
                    if indexPath.item == i{
                        switch i{
                        case 0:
                            for j in 0..<7{
                                if listCell.rigntStackView[j].tag == j+1{
                                    listCell.rigntStackView[j].text = "\(rightCheckOrderInfo[j].itemName)"
                                    listCell.rigntStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[j]))")
                                }
                            }
                        case 1:
                            for j in 0..<7{
                                if listCell.rigntStackView[j].tag == j+1{
                                    listCell.rigntStackView[j].text = "\(self.rightCheckOrderInfo[j+7].itemName)"
                                    listCell.rigntStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[j+7]))")
                                }
                            }
                        case 2:
                            for j in 0..<7{
                                if listCell.rigntStackView[j].tag == j+1{
                                    listCell.rigntStackView[j].text = "\(self.rightCheckOrderInfo[j+14].itemName)"
                                    listCell.rigntStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[j+14]))")
                                }
                            }
                        case 3:
                            for j in 0..<7{
                                if listCell.rigntStackView[j].tag == j+1{
                                    listCell.rigntStackView[j].text = "\(self.rightCheckOrderInfo[j+21].itemName)"
                                    listCell.rigntStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[j+21]))")
                                }
                            }
                        case 4:
                            for j in 0..<7{
                                if listCell.rigntStackView[j].tag == j+1{
                                    listCell.rigntStackView[j].text = "\(self.rightCheckOrderInfo[j+28].itemName)"
                                    listCell.rigntStackImage[j].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[j+28]))")
                                }
                            }
                            
                        default: break
                        }
                    }
                }
            // 나머지에 관하여 오른쪽 값
            if indexPath.item == rigntValue{
                print("오른쪽 나머지 갑 \(rigntRemainder)")
                // rightReminder가 0일경우
                if rigntRemainder == 0 {
                    print("여기서 오류났니?")
                    for i in rigntRemainder..<7 {
                        if listCell.rigntStackView[i].tag == i+1 && listCell.rigntStackImage[i].tag == i+1 {
                            listCell.rigntStackView[i].text = " "
                            listCell.rigntStackImage[i].image = UIImage(named: "homeIcCheck")
                        }
                    }
                }else if rigntRemainder == 6{
                    for i in 0..<rigntRemainder+1{
                        if listCell.rigntStackView[i].tag == i+1 {
                            listCell.rigntStackView[i].text = "\(self.rightCheckOrderInfo[i+(rigntValue)*7].itemName)"
                            listCell.rigntStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[i+((rigntValue)*7)]))")
                        }
                    }
                }else{
                    // 나머지 값에 관해서
                    for i in 0..<rigntRemainder{
                        if listCell.rigntStackView[i].tag == i+1 {
                            listCell.rigntStackView[i].text = "\(self.rightCheckOrderInfo[i+(rigntValue)*7].itemName)"
                            listCell.rigntStackImage[i].image = UIImage(named: "\(onOff(flagInt: self.rightFlagInt[i+((rigntValue)*7)]))")
                        }
                    }
                    
                    for i in rigntRemainder..<7 {
                        if listCell.rigntStackView[i].tag == i+1 && listCell.rigntStackImage[i].tag == i+1 {
                            listCell.rigntStackView[i].text = " "
                            listCell.rigntStackImage[i].image = UIImage(named: "homeIcCheck")
                        }
                    }
                }
            }else{
                print("오른쪽 나머지 값 else구문 \(rigntRemainder)")
            }
        }

        return listCell
    }
}


// MARK: UICollectionView Delegate
extension HomeNewVC: UICollectionViewDelegate{
    
    //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        curentpage = Int(targetContentOffset.pointee.x / homeListCollectionView.frame.size.width)
    //      self.pageControl.currentPage = curentpage
    //
    //        print("\(curentpage)")
    //    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        curentpage =  Int(floorf(Float(homeListCollectionView.contentOffset.x)/Float(homeListCollectionView.frame.size.width)))
        
        pageControl.currentPage = curentpage
        
    }
    
}

//  MARK: sideMenu 만든 Delegate
extension HomeNewVC : UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
