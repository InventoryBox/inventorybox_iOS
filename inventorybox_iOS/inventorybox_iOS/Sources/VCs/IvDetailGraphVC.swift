//
//  IvDetailGraphVC.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts


class IvDetailGraphVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ChartViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet var backgroundPopupView: UIView!
    @IBOutlet var popupBackgroundView: UIView!
    var toggleBtnClickCount:Int = 0
    var compareBtnClickCount:Int = 0
    var alarmCnt:Int?
    var isClickedBtn:Bool?
    var alarmUnit:String?
    var originalMemoCnt:Int?
    
    var btnArray:[String] = []
    var reloadArray:[WeekInformation] = [] {
        didSet {
            self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
    var itemWeekData:[SingleGraphWeekInfo] = [] {
        didSet {
            self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
    var itemWeekDataClone:[SingleGraphWeekInfo] = []
    
    var newnewData:[SingleGraphData] = []
    
    var itemGraphData:[GraphInfo] = []
    var itemGraphDataClone:[GraphInfo] = []
    var doubleGraphArray:[DetailCompareGraphInfo] = []
    var itemName:String?
    var isSelected:[Bool] = []
    let date = Date()
    let calendar = Calendar.current
    var selectedFirstYearTextField:String = ""
    var selectedFirstMonthTextField:String = ""
    var selectedFirstWeekTextField:String = ""
    var selectedSecondYearTextField:String = ""
    var selectedSecondMonthTextField:String = ""
    var selectedSecondWeekTextField:String = ""
    var selectedYearTextField:String = ""
    var selectedMonthTextField:String = ""
    var plusZeroMonthTextField:String = ""
    var itemIdx:Int?
    var compareGraphWeek1Array:[Int] = [0,0,0,0,0,0,0]
    var compareGraphWeek2Array:[Int] = [0,0,0,0,0,0,0]
    var graphArray:[GraphInfo] = [] {
        didSet {
            self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
    
    var graphCount:Int = 0
    var getWeekCount:Int = 0
    var weekBtnText:String = ""
    var weekInfoArray:[WeekInformation] = []
    
    // 이 값 순서대로 그래프가 그려짐
    // 서버통신 시 inventory별 정보 배열이 들어갈 곳
    let singleGraphUniteSold = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    
    let doubleGraphUniteSold1 = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    let doubleGraphUniteSold2 = [2.0,11.0,9.0,10.0,3.0,4.0,2.0]
    
    var days: [String]!
    var graph2Days:[String]!
    
    
    var clickBtnWeek:Int?
    var whatWeekIs:String?
    
    @IBOutlet var ivDetilTV: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        currentSingleGraphNetworking()
        print("current",itemGraphData)
        
        //네비게이션 바 나타나게 하는 코드
        self.navigationController?.navigationBar.isHidden = false
        ivDetilTV.delegate = self
        ivDetilTV.dataSource = self
        
        self.navigationItem.title = itemName
        ivDetilTV.allowsSelection = false
        ivDetilTV.separatorStyle = .none
        ivDetilTV.contentInsetAdjustmentBehavior = .never
        setPopupBackgroundView()
        ivDetilTV.allowsSelection = false
        ivDetilTV.separatorStyle = .none
        
        
        
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        let current_year_string = formatter_year.string(from: Date())
        selectedYearTextField = "\(current_year_string)"
        let formatter_month = DateFormatter()
        formatter_month.dateFormat = "MM"
        let current_month_string = formatter_month.string(from: Date())
        plusZeroMonthTextField = "\(current_month_string)"
        
        NotificationCenter.default.addObserver(self, selector: #selector(setWeeks(_:)), name: .clickWeek, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setWeeks(_:)), name: .setWeek, object: nil)
        
        
    }
    
    func currentSingleGraphNetworking(){
        self.reloadArray = []
        print("몇벙림?",itemIdx!)
        SingleGraphLoadService.shared.loadCompareGraph(itemIdx!, (calendar.component(.year, from: date)), (calendar.component(.month, from: date)), completion:  { networkResult in
            switch networkResult{
            case .success(let data):
                
                
                guard let singleGraphData = data as? SingleGraphWeekInfo else {
                    return }
                
                
                self.itemWeekData = [singleGraphData]
                self.getWeekCount = singleGraphData.weeksCnt
                self.itemGraphData = singleGraphData.graphInfo
                self.alarmCnt = singleGraphData.alarmCnt
                self.originalMemoCnt = singleGraphData.memoCnt
                //  self.itemWeekDataClone = self.itemWeekData
                print(self.getWeekCount)
                print("넘어오니",self.itemGraphData)
                self.weekInfoArray = []
                self.graphCount = 0
                
                
                let thisWeekCount = Calendar.current.component(.weekOfMonth, from: self.date)
                
                
                for i in 0...thisWeekCount - 1 {
                    
                    print("첫번째 안녕안녕",i)
                    print("여긴테이블뷰",thisWeekCount)
                    
                    if i == 0 {
                        self.weekBtnText = "첫째주"
                    } else if i == 1 {
                        self.weekBtnText = "둘째주"
                    } else if i == 2 {
                        self.weekBtnText = "셋째주"
                    } else if i == 3 {
                        self.weekBtnText = "넷째주"
                    } else if i == 4 {
                        self.weekBtnText = "다섯째주"
                    } else if i == 5 {
                        self.weekBtnText = "여섯째주"
                    } else {
                        self.weekBtnText = "일곱째주"
                    }
                    
                    if self.graphCount < thisWeekCount {
                        self.weekInfoArray.append(WeekInformation(btnText: self.weekBtnText, btnIsSelected: true))
                        
                        self.graphCount += 1
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    
                    //첫번째 섹션만 reload하게.
                    
                    self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
                    
                    print("첫번째 로드",self.reloadArray)
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
        })
        
        //  self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
        //roxaneamethy@gmail.com
        
    }
    
    @objc func setWeeks(_ notification: NSNotification) {
        print("ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ")
        guard let row = notification.userInfo?["week"] as? Int else { return }
        guard let status = notification.userInfo?["status"] as? Bool else { return }
        
        clickBtnWeek = row
        reloadArray = weekInfoArray
        itemGraphDataClone = itemGraphData
    
        print("dmlmlml",itemGraphDataClone)
        print(status)
        
        // 초기 상태값으로 움직임
        if status == false {
            print("안뇽? 클레오파트라?",weekInfoArray.count)
            for i in 0...weekInfoArray.count - 1{
                if clickBtnWeek! == i  {
                    print("행복해~~~~~~~",clickBtnWeek!)
                    print(reloadArray)
                    reloadArray.remove(at: i)
                    itemGraphDataClone.remove(at: i)
                    
                    print(reloadArray)
                    print(itemGraphDataClone)
                    //self.graphArray.sort{$0.startDay! < $1.itemIndex!}
                    //print(reloadArray)
                    ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
                }
            }
        }
        
        else {
            for i in 0...weekInfoArray.count - 1{
                if clickBtnWeek == i {
                    reloadArray.append(weekInfoArray[i])
                    //print(reloadArray)
                    //                     self.reloadArray.sort{$0.itemIndex! < $1.itemIndex!}
                    //print(reloadArray)
                    ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
                }
            }
        }
        
    }
    
    
    private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSecondDisappearPopup), name: .init("popup"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFirstDisappearPopup), name: .init("popup"), object: nil)
    }
    
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let year = info["year"] as? String else { return }
        guard let month = info["month"] as? String else {return}
        guard let week = info["week"] as? String else {return}
        
        
        selectedFirstYearTextField = year
        selectedFirstMonthTextField = month
        selectedFirstWeekTextField = week
        
        ivDetilTV.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    @objc func didSecondDisappearPopup(_ notification: Notification) {
        
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        
        guard let secondYear = info["secondYear"] as? String else {return}
        guard let secondMonth = info["secondMonth"] as? String else {return}
        guard let secondWeek = info["secondWeek"] as? String else {return}
        
        selectedSecondYearTextField = secondYear
        selectedSecondMonthTextField = secondMonth
        selectedSecondWeekTextField = secondWeek
        
        
        ivDetilTV.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    @objc func didFirstDisappearPopup(_ notification: Notification) {
        //첫번째 datePicker
        
        animatePopupBackground(false)
        guard let info = notification.userInfo as? [String: Any] else { return }
        
        guard let firstYear = info["firstYear"] as? String else {return}
        guard let firstMonth = info["firstMonth"] as? String else {return}
        
        
        let thisMonth = Calendar.current.component(.month, from: self.date)
        let thisYear = Calendar.current.component(.year, from: self.date)
        
        
        //미래 날짜로 이동할 수 없도록 설정
        if firstMonth.toInt()! > thisMonth || firstYear.toInt()! > thisYear {
            
            let alert = UIAlertController(title: "", message: "미래의 날짜로 이동할 수 없습니다", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                        
                    }
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            
            
            return
        }
        
        
        selectedYearTextField = firstYear
        
        if Int(firstMonth)! < 10 {
            plusZeroMonthTextField = "0" + firstMonth
        }
        else {
            plusZeroMonthTextField = firstMonth
        }
        
        selectedMonthTextField = firstMonth
        
        print(selectedYearTextField)
        print(plusZeroMonthTextField)
        
      
        if selectedMonthTextField.toInt()! == thisMonth {
            SingleGraphLoadService.shared.loadCompareGraph(itemIdx!, selectedYearTextField.toInt()!, selectedMonthTextField.toInt()!, completion:  { networkResult in
                switch networkResult{
                case .success(let data):
                    guard let singleGraphData = data as? SingleGraphWeekInfo else {
                        return }
                    self.reloadArray = []
                    self.itemWeekData = [singleGraphData]
                    self.getWeekCount = singleGraphData.weeksCnt
                    self.itemGraphData = singleGraphData.graphInfo
                    self.alarmCnt = singleGraphData.alarmCnt
                    
                    print(self.getWeekCount)
                    self.weekInfoArray = []
                    self.graphCount = 0
                    let thisWeekCount = Calendar.current.component(.weekOfMonth, from: self.date)
                    
                    for i in 0...thisWeekCount - 1 {
                        
                        print("안녕안녕",i)
                        print("여긴테이블뷰",thisWeekCount)
                        
                        if i == 0 {
                            self.weekBtnText = "첫째주"
                            print(self.weekBtnText)
                        } else if i == 1 {
                            self.weekBtnText = "둘째주"
                        } else if i == 2 {
                            self.weekBtnText = "셋째주"
                            print(self.weekBtnText)
                        } else if i == 3 {
                            self.weekBtnText = "넷째주"
                            print(self.weekBtnText)
                        } else if i == 4 {
                            self.weekBtnText = "다섯째주"
                            print(self.weekBtnText)
                        } else if i == 5 {
                            self.weekBtnText = "여섯째주"
                            print(self.weekBtnText)
                        } else {
                            self.weekBtnText = "일곱째주"
                            print(self.weekBtnText)
                        }
                        
                        
                        print(self.graphCount)
                        print(self.getWeekCount)
                        if self.graphCount < thisWeekCount {
                            self.weekInfoArray.append(WeekInformation(btnText: self.weekBtnText, btnIsSelected: true))
                            self.graphCount += 1
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        
                        //첫번째 섹션만 reload하게.
                        
                        self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
                        
                        print("귀여운",self.reloadArray)
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
            })
        }
        
        else {
            SingleGraphLoadService.shared.loadCompareGraph(itemIdx!, selectedYearTextField.toInt()!, selectedMonthTextField.toInt()!, completion:  { networkResult in
                switch networkResult{
                case .success(let data):
                    guard let singleGraphData = data as? SingleGraphWeekInfo else {
                        return }
                    self.reloadArray = []
                    self.itemWeekData = [singleGraphData]
                    self.getWeekCount = singleGraphData.weeksCnt
                    self.itemGraphData = singleGraphData.graphInfo
                    self.alarmCnt = singleGraphData.alarmCnt
                    // self.reloadArray = self.itemWeekData
                    print(self.getWeekCount)
                    self.weekInfoArray = []
                    self.graphCount = 0
                    for i in 0...self.getWeekCount - 1 {
                        
                        print("안녕안녕",i)
                        print("여긴테이블뷰",self.getWeekCount)
                        
                        if i == 0 {
                            self.weekBtnText = "첫째주"
                            print(self.weekBtnText)
                        } else if i == 1 {
                            self.weekBtnText = "둘째주"
                        } else if i == 2 {
                            self.weekBtnText = "셋째주"
                            print(self.weekBtnText)
                        } else if i == 3 {
                            self.weekBtnText = "넷째주"
                            print(self.weekBtnText)
                        } else if i == 4 {
                            self.weekBtnText = "다섯째주"
                            print(self.weekBtnText)
                        } else if i == 5 {
                            self.weekBtnText = "여섯째주"
                            print(self.weekBtnText)
                        } else {
                            self.weekBtnText = "일곱째주"
                            print(self.weekBtnText)
                        }
                        
                        
                        print(self.graphCount)
                        print(self.getWeekCount)
                        if self.graphCount < self.getWeekCount {
                            self.weekInfoArray.append(WeekInformation(btnText: self.weekBtnText, btnIsSelected: true))
                            self.graphCount += 1
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        
                        //첫번째 섹션만 reload하게.
                        
                        self.ivDetilTV.reloadSections(IndexSet(integer: 0), with: .none)
                        
                        print("귀여운",self.reloadArray)
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
            })
        }
    }
    
    
    @IBAction func dayPickerBtn(_ sender: UIButton) {
        animatePopupBackground(true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvCompareGraphVC") as? IvCompareGraphVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func secondDatePickerBtn(_ sender: UIButton) {
        animatePopupBackground(true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvDetailGraphSecondCompareVC") as? IvDetailGraphSecondCompareVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func firstDayPickerBtn(_ sender: UIButton) {
        
        toggleBtnClickCount += 1
        print(toggleBtnClickCount)
        animatePopupBackground(true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IvGraphDetailPicekrVC") as? IvGraphDetailPicekrVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    
    @IBAction func compareBtn(_ sender: UIButton) {
        
        let contentView = sender.superview
        let cell = contentView?.superview as! UITableViewCell
        let cellIndexPath = ivDetilTV.indexPath(for: cell)
        print(cellIndexPath)
        
        InventoryCompareGraphService.shared.loadCompareGraph(itemIdx!, Int(selectedFirstYearTextField)!, Int(selectedFirstMonthTextField)!, Int(selectedFirstWeekTextField)!, Int(selectedSecondYearTextField)!, Int(selectedSecondMonthTextField)!, Int(selectedSecondWeekTextField)!, completion: { networkResult in
            switch networkResult{
            case .success(let data):
                guard let compareData = data as? CompareWeekData else {
                    return}
                
                self.compareGraphWeek1Array = compareData.week1
                self.compareGraphWeek2Array = compareData.week2
                
                DispatchQueue.main.async {
                    
                    self.compareBtnClickCount = 0
                    self.compareBtnClickCount = 1
                    self.ivDetilTV.reloadSections(IndexSet(integer: 1), with: .none)
                    //self.ivDetilTV.reloadData()
                    //roxaneamethy@gmail.com
                    
                }
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
                
            case .serverErr: print("serverErr")
            case .pathErr:
                print("pathErr")
                
                
                DispatchQueue.main.async {
                    
                    self.compareBtnClickCount = 0
                    self.compareBtnClickCount = 5
                    
                    self.ivDetilTV.reloadSections(IndexSet(integer: 1), with: .none)
                    
                }
                
//                roxaneamethy@gmail.com
            case .networkFail:
                print("networkFail")
            }
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            if clickBtnWeek == 0 {
                print("클릭0",clickBtnWeek)
                print("리로드어레이0",reloadArray)
                
                return reloadArray.count + 1
            }
            else if clickBtnWeek == 1 {
                print("클릭1",clickBtnWeek)
                print("리로드어레이1",reloadArray)
                return reloadArray.count + 1
            }
            else if clickBtnWeek == 2 {
                print("클릭2",clickBtnWeek)
                print("리로드어레이2",reloadArray)
                return reloadArray.count + 1
            }
            else if clickBtnWeek == 3 {
                print("클릭3",clickBtnWeek)
                print("리로드어레이3",reloadArray)
                return reloadArray.count + 1
            }
            else if clickBtnWeek == 4 {
                print("클릭4",clickBtnWeek)
                print("리로드어레이4",reloadArray)
                return reloadArray.count + 1
            }
            else if clickBtnWeek == 5 {
                print("클릭6",clickBtnWeek)
                print("리로드어레이6",reloadArray)
                return reloadArray.count + 1
            }
            else  {
                print("여기이이이이이이")
                print(reloadArray)
                print(reloadArray.count + 1)
                return reloadArray.count + 1
            }
            
        }
        else if section == 1 {
            return 1
        }
        
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailGraphTVHeaderCell") as! IvDetailGraphTVHeaderCell
                
                
                headerCell.yearLabel.text = selectedYearTextField
                headerCell.monthLabel.text = plusZeroMonthTextField
                headerCell.itemIdx = itemIdx!
                headerCell.weekArray = itemWeekData
                
                if toggleBtnClickCount == 0 {
                    print("toggle",toggleBtnClickCount)
                    
                    
                    var month = calendar.component(.month, from: date)
                    var thisYear = calendar.component(.year, from: date)
                    
                    let dateComponents = DateComponents.init(year: thisYear, month: month)
                    let monthCurrentDayFirst = Calendar.current.date(from: dateComponents)!
                    let monthNextDayFirst = Calendar.current.date(byAdding: .month, value: 1, to: monthCurrentDayFirst)!
                    let monthCurrentDayLast = Calendar.current.date(byAdding: .day, value: -1, to: monthNextDayFirst)!
                    
                    let thisWeekCount = Calendar.current.component(.weekOfMonth, from: date)
                    
                    let numberOfWeeks = Calendar.current.component(.weekOfMonth, from: monthCurrentDayLast)
                    
                    
                    for i in 0...thisWeekCount - 1 {
                        
                        
                        if i == 0 {
                            self.weekBtnText = "첫째주"
                        } else if i == 1 {
                            self.weekBtnText = "둘째주"
                        } else if i == 2 {
                            self.weekBtnText = "셋째주"
                        } else if i == 3 {
                            self.weekBtnText = "넷째주"
                        } else if i == 4 {
                            self.weekBtnText = "다섯째주"
                        } else if i == 5 {
                            self.weekBtnText = "여섯째주"
                        } else {
                            self.weekBtnText = "일곱째주"
                        }
                        
                        if self.graphCount < thisWeekCount {
                            self.weekInfoArray.append(WeekInformation(btnText: self.weekBtnText, btnIsSelected: true))
                            
                            self.graphCount += 1
                        }
                    }
                    
                    //collectionarray true 배열
                    headerCell.collectionArray = weekInfoArray
                }
                
                if toggleBtnClickCount > 0 {
                    headerCell.collectionArray = weekInfoArray
                }
                
                return headerCell
            }
            
            else {
                guard let weekGraphCell = tableView.dequeueReusableCell(withIdentifier: "IvDetailWeekGraphTVCell", for:indexPath) as? IvDetailWeekGraphTVCell else {return UITableViewCell()}
                
                
                if clickBtnWeek == 0 {
                    
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                    
                }
                else if clickBtnWeek == 1 {
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row - 1], alarmCount: alarmCnt! , weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                    
                }
                else if clickBtnWeek == 2 {
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row - 1], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                    
                }
                else if clickBtnWeek == 3 {
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row - 1], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                    
                }
                else if clickBtnWeek == 4 {
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row - 1], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                    
                }
                else if clickBtnWeek == 5 {
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row - 1], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                    
                }
                else if clickBtnWeek == 6{
                    weekGraphCell.bindGraph(model: itemGraphDataClone[indexPath.row - 1], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                }
                else if clickBtnWeek == nil {
                    print("여기는 왜 출력이 안돼..?")
                    weekGraphCell.bindGraph(model: itemGraphData[indexPath.row - 1], alarmCount: alarmCnt!, weekLabel: weekInfoArray[indexPath.row - 1].btnText, itemIndex: itemIdx!, monthInfo: selectedMonthTextField)
                }
                return weekGraphCell
            }
        }
        
        
        else if indexPath.section == 1 {
            let IvWeekCompareGraphTVCell = tableView.dequeueReusableCell(withIdentifier: "IvWeekCompareGraphTVCell") as! IvWeekCompareGraphTVCell
            
            //print(selectedSecondWeekTextField)
            //  roxaneamethy@gmail.com
            
            let valFormatter = NumberFormatter()
            valFormatter.numberStyle = .currency
            valFormatter.maximumFractionDigits = 2
            valFormatter.currencySymbol = "$"
            
            
            let format = NumberFormatter()
            format.numberStyle = .none
            let formatter = DefaultValueFormatter(formatter: format)
            
            var dataPoints: [String] = ["일","월","화","수","목","금","토"]
            var dataEntries: [BarChartDataEntry] = []
            var dataEntries2: [BarChartDataEntry] = []
            
            
            IvWeekCompareGraphTVCell.compareChartView.delegate = self
            IvWeekCompareGraphTVCell.compareChartView.noDataText = "비교하실 주차를 선택해 주세요."
            IvWeekCompareGraphTVCell.compareChartView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
            IvWeekCompareGraphTVCell.compareChartView.chartDescription?.textColor = UIColor.clear
            
            
            
            IvWeekCompareGraphTVCell.yearTextField.text = selectedFirstYearTextField
            IvWeekCompareGraphTVCell.monthTextField.text = selectedFirstMonthTextField
            IvWeekCompareGraphTVCell.weekTextField.text = selectedFirstWeekTextField
            IvWeekCompareGraphTVCell.secondYearTextField.text = selectedSecondYearTextField
            IvWeekCompareGraphTVCell.secondMonthTextField.text = selectedSecondMonthTextField
            IvWeekCompareGraphTVCell.secondWeekTextField.text = selectedSecondWeekTextField
            
            
            
            
            
            if IvWeekCompareGraphTVCell.yearTextField.text == "" {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = false
            }
            else if IvWeekCompareGraphTVCell.weekTextField.text == "" {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = false
            }
            else if IvWeekCompareGraphTVCell.weekTextField.text == "" {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = false
            }
            else if IvWeekCompareGraphTVCell.secondYearTextField.text == "" {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = false
            }
            else if IvWeekCompareGraphTVCell.secondMonthTextField.text == "" {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = false
            }
            else if IvWeekCompareGraphTVCell.secondWeekTextField.text == "" {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = false
            }
            else {
                IvWeekCompareGraphTVCell.compareBtn.isEnabled = true
                IvWeekCompareGraphTVCell.compareBtn.backgroundColor = .yellow
                IvWeekCompareGraphTVCell.compareBtn.setTitleColor(.white, for: .normal)
            }
            
            
            if compareBtnClickCount == 5 {
                
                IvWeekCompareGraphTVCell.compareChartView.setNeedsDisplay()
                IvWeekCompareGraphTVCell.compareChartView.noDataText = "해당 주차에 입력된 데이터가 없습니다."
            }
            
            
            
            if compareBtnClickCount == 1 {
                
                
                print("돼요")
                
                for i in 0...6 {
                    let dataEntry = BarChartDataEntry(x: Double(i), y: Double(compareGraphWeek1Array[i]))
                    dataEntries.append(dataEntry)
                    print(dataEntries)
                    
                }
                
                for i in 0...6 {
                    let dataEntry = BarChartDataEntry(x: Double(i), y: Double(compareGraphWeek2Array[i]))
                    dataEntries2.append(dataEntry)
                    print(dataEntries2)
                }
                
                
                let chartDataSet = BarChartDataSet(entries: dataEntries, label: " ")
                let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: " ")
                
                chartDataSet.colors = [UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)]
                
                chartDataSet2.colors =  [UIColor(red: 246/255, green: 187/255, blue: 51/255, alpha: 1)]
                
                
                
                let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet2]
                let data = BarChartData(dataSets: dataSets)
                data.setValueFormatter(formatter)
                
                let groupSpace = 0.3
                let barSpace = 0.02
                let barWidth = groupSpace
                
                
                let groupCount = dataPoints.count
                let startYear = 0
                
                
                data.barWidth = barWidth;
                IvWeekCompareGraphTVCell.compareChartView.xAxis.axisMinimum = Double(startYear)
                let gg = data.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
                //
                //            IvWeekCompareGraphTVCell.compareChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
                
                data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
                
                
                IvWeekCompareGraphTVCell.compareChartView.data = data
                
                //IvWeekCompareGraphTVCell.compareChartView.setVisibleXRangeMaximum(15)
                IvWeekCompareGraphTVCell.compareChartView.animate(yAxisDuration: 1.0, easingOption: .easeInOutBounce)
                IvWeekCompareGraphTVCell.compareChartView.delegate = self
                IvWeekCompareGraphTVCell.compareChartView.noDataText = "You need to provide data for the chart."
                IvWeekCompareGraphTVCell.compareChartView.chartDescription?.textColor = UIColor.clear
                IvWeekCompareGraphTVCell.compareChartView.data = data
                
                
                IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawGridLinesEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawAxisLineEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawLabelsEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                
                
                
                IvWeekCompareGraphTVCell.compareChartView.xAxis.labelPosition = .bottom
                IvWeekCompareGraphTVCell.compareChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
                IvWeekCompareGraphTVCell.compareChartView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
                //IvWeekCompareGraphTVCell.compareChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
                IvWeekCompareGraphTVCell.compareChartView.xAxis.drawGridLinesEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.leftAxis.drawLabelsEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawGridLinesEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawLabelsEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.leftAxis.drawAxisLineEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.rightAxis.drawAxisLineEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.leftAxis.drawGridLinesEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.drawGridBackgroundEnabled = false
                IvWeekCompareGraphTVCell.compareChartView.drawBordersEnabled = false
                
                
                //밑에 데이터셋 제거
                IvWeekCompareGraphTVCell.compareChartView.legend.enabled = true
                
                data.barWidth = 0.15
            }
            
            
            
            return IvWeekCompareGraphTVCell
            
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IvEditTVCell") as! IvEditTVCell
            cell.itemIdx = itemIdx
            cell.alarmCnt = alarmCnt
            cell.memoCnt = originalMemoCnt
            cell.delegate = self
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 79
            }
            else {
                return 185
            }
        }
        
        if indexPath.section == 1 {
            return 319
        }
        
        return 160
        
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
