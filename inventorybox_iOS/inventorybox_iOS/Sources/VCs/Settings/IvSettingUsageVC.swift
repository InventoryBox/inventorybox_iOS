//
//  IvSettingUsageVC.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class IvSettingUsageVC: UIViewController {
    static let identifier: String = "IvSettingUsageVC"
    
    var navigationTitle: String?
    
    let menuArray: [String] = ["기본", "재고기록", "발주 알림", "재고량 추이", "재고교환"]
    
    var tableViewArray: [QuestionData] = []
    var titleTableArray: TitleData = TitleData(title: "", detail: "")
    
    var titleArray: [TitleData] = {
        let t1 = TitleData(title: "재고기록", detail: "당일의 재고량을 쉽게 기록하고 데이터를 축적할 수 있습니다.\n재료추가를 할 때 발주 알림 기준과 발주할 수량을 설정할 수 있습니다.\n")
        let t2 = TitleData(title: "발주 알림(홈)", detail: "당일 발주가 필요한 재료들의 알림이 뜨고, 사용자가 체크박스를 이용하여 스스로 발주 여부를 확인할 수 있도록 돕습니다.\n재료별로 발주할 개수를 메모하여 일일이 기억할 필요 없이 편하게 발주를 할 수 있습니다.\n‘자세히’버튼을 눌렀을 때 5일간의 재고량 추이가 제공되어 사용자가 발주할 개수를 결정하는데 도움을 줍니다.\n")
        let t3 = TitleData(title: "재고량추이", detail: "사용자가 기록한 데이터가 주간 별로 나타나 모든 재료의 재고량 추이를 한눈에 볼 수 있습니다.\n발주알림개수 이하일 때 막대그래프가 노란색으로 표시되고, 이 간격을 통해 발주 주기를 파악할 수 있습니다.\n주간별 재고량 비교 기능을 통해 계절 또는 분기에 따른 재고량 차이를 파악할 수 있습니다. 사용자는 이러한 통계치를 바탕으로 발주 알림 개수와 발주할 수량을 조절할 수 있습니다.\n")
        let t4 = TitleData(title: "재고교환: 서비스 오픈 준비 중입니다", detail: "재고교환은 외식사업자들의 식품 및 공산품 중고거래 플랫폼입니다.\n사용자가 가게 위치를 중심으로 반경 2km 내 가게들과 교류가 가능한 형식의 위치 기반 직거래 만을 취급합니다.\n\n최초 사용시, 어떻게 사용하나요?\n\n1. 내가게위치설정을합니다.\n2. 내가게를중심으로반경2km내게시물이뜨게됩니다.\n3. 제품을 사는 경우: 원하는 제품을 발견한 경우, 전화하기 버튼을 눌러 판매자와 거래할 수 있습니다.\n모든 거래는 직거래입니다.\n4. 제품을파는경우:오른쪽하단의플러스버튼을통해제품등록글을작성할수있습니다.\n거래를 완료를 한 후에는 거래 완료 버튼을 눌러야 게시물이 사라지게 됩니다.")
        
        return [t1, t2, t3, t4]
    }()
    var ivRecordQuestionArray: [QuestionData] = {
        var q0 = QuestionData(question: "", answer: "", open: false)
        var q1 = QuestionData(question: "재고기록은 어떻게 하나요?", answer: "재고기록 탭을 누르면 메인 페이지에 뜨는 ‘오늘 재고 등록하기’ 버튼을 통해 재고기록이 가능합니다.\n\n", open: false)
        var q2 = QuestionData(question: "실수로 어제 재고기록을 깜빡 했어요 ㅠㅠ 어떻게 해야 하나요?", answer: "과거의 재고 기록을 하고 싶은 경우 상단 날짜를 과거로 돌려서 오른쪽 상단의 재고량 '수정버튼' 을 이용해 수정할 수 있습니다.\n\n", open: false)
        var q3 = QuestionData(question: "재고기록 수정은 어디서 하나요?", answer: "오른쪽 상단의 ‘재고량 수정’버튼을 통해 기록 수정이 가능합니다.\n\n", open: false)
        var q4 = QuestionData(question: "재료 등록 방법은 무엇인가요?", answer: "왼쪽 상단의 재료추가 버튼을 이용합니다. \n1. 아이콘을 정해주세요.(선택사항)\n2. 단위를 설정해주세요.\n3. 카테고리를 설정해주세요.\n4. 발주 알림 개수를 선정해주세요. 이 개수를 기준으로 잔여재고량이 설정값 이하가 되면 홈에 발주 알림이 뜨게 됩니다.\n발주 알림 개수는 재고량 추이 탭에서 상세 재료를 눌러서 수정이 가능해요.\n5. 발주할 수량을 메모해주세요. 여러분이 주로 발주하는 량을 메모해두는 기능이에요.\n발주수량메모는 홈에서 ‘발주 확인 상세보기’에서도 수정이 가능해요. 또, 재고량 추이 탭에서 상세 재료를 눌러서도 수정할 수 있어요..\n\n", open: false)
        var q5 = QuestionData(question: "과거 재고기록 보기", answer: "날짜 스피너를 과거로 돌리면 과거 재고기록을 볼 수 있습니다.\n\n", open: false)
        var q6 = QuestionData(question: "카테고리 추가, 이동, 삭제", answer: "오른쪽 상단의 폴더 버튼을 누르면 카테고리 편집이 가능합니다.\n이곳에서 새로운 카테고리를 추가할 수도 있고, 재료를 다른 카테고리로 이동할 수 있으며, 카테 고리명을 삭제할 수 있습니다.\n\n", open: false)
        var q7 = QuestionData(question: "재료 삭제", answer: "오른쪽 상단의 폴더 버튼을 누르면 재료삭제가 가능합니다.\n삭제를 원하는 재료를 클릭하면 당일 재고기록부터 삭제된 재료는 뜨지 않습니다. \n과거 기록에 대해서는 재료에 대한 기록이 남아있습니다.\n\n\n", open: false)
        
        return [q0, q1, q2, q3, q4, q5, q6, q7]
    }()
    
    var homeQuestionArray: [QuestionData] = {
        let q0 = QuestionData(question: "", answer: "", open: false)
        let q1 = QuestionData(question: "발주 알림은 무엇을 기준으로 뜨게 되나요?", answer: "재료 등록 시, 설정해 둔 발주 알림 기준 개수를 기준으로 잔여 재고량이 설정값 이하인 경우에 발주 알림이 뜨게 됩니다.\n\n", open: false)
        let q2 = QuestionData(question: "발주 알림 기준 개수 수정은 어디서 가능한가요?", answer: "수정은 재고량 추이 탭 > 해당 재료 클릭 > 아래로 스와이프하여 발주 알림 기준 개수 수정이 가능합니다.\n\n", open: false)
        let q3 = QuestionData(question: "발주 수량 메모 기능은 무엇인가요?", answer: "일반적으로 재료에 대해서 발주를 할 때 몇 개를 하는지 메모해 둘 수 있는 기능입니다.\n 이를 통해, 일일히 모든 재료의 발주량을 외울 필요 없이 편하게 기억할 수 있습니다.\n\n", open: false)
        let q4 = QuestionData(question: "발주 수량 메모 수정은 어디서 가능한가요?", answer: "‘발주 알림 상세보기’ 버튼 > 발주확인 페이지에서 오른쪽 상단 ‘메모수정’ 버튼을 통해서 수정이 가능합니다.\n또는 재고량 추이 탭 > 해당 재료 선택 > 아래로 스와이프 하여 발주 수량 메모를 수정할 수 있습니다.\n\n", open: false)
        let q5 = QuestionData(question: "발주알림 상세보기에서 ‘자세히’버튼의 기능은 무엇인가요?", answer: "최근 5일간의 재고량을 보여줍니다. 이를 참고하여 발주할 수량을 정할 수 있습니다.\n\n", open: false)
        let q6 = QuestionData(question: "각 재료별 통계치를 더 많이 보고 싶다면 어떻게 해야 하나요?", answer: "재고량 추이 탭으로 가서 해당 재료를 클릭하면, 주간, 월간 재고량 통계치를 확인할 수 있습니다.\n\n", open: false)
        let q7 = QuestionData(question: "프로필 및 아이디 비밀번호 변경은 어떻게 하나요?", answer: "메인 화면 오른쪽 상단의 햄버거 바를 눌러주세요.\n이 곳에서 프로필, 개인 정보, 이메일 및 비밀번호 변경이 가능합니다.\n\n", open: false)
        return [q0, q1, q2, q3, q4, q5, q6, q7]
    }()
    
    var graphQuestionArray: [QuestionData] = {
        let q0 = QuestionData(question: "", answer: "", open: false)
        let q1 = QuestionData(question: "주간 재고량 통계를 어떻게 활용할 수 있을까요?", answer: "발주 알림 기준 개수 이하인 그래프는 노란색 그래프로 표시됩니다.\n노란색 그래프의 간격을 통해 발주주기를 확인할 수 있을 것입니다. 노란색 그래프의 간격(발주주 기)가 너무 길다면 발주량을 줄일 필요가 있겠죠? 또 노란색 그래프의 간격(발주 주기)이 너무 짧 다면 발주량을 늘릴 필요가 있을 것 입니다.\n\n", open: false)
        let q2 = QuestionData(question: "주간 별 재고량 비교 기능을 어떻게 활용할 수 있을까요?", answer: "이는 재료의 계절, 분기 별 재고량 차이 파악을 할 수 있습니다. 예를 들어, 여름의 시작이라고 할 수 있는 6월 첫째 주와, 겨울의 시작이라고 할 수 있는 11월 첫째 주의 재고량 비교를 통해 여름철과 겨울철의 발주량을 다르게 조절할 수 있을 것 입니다.\n\n", open: false)
        let q3 = QuestionData(question: "과거의 재고량 통계를 보고 싶어요", answer: "날짜 스피너를 과거로 돌려서 지난 재고량 통계를 볼 수 있습니다.\n\n", open: false)
        
        return [q0, q1, q2, q3]
    }()
    
    var exchangeQuestionArray: [QuestionData] = {
        let q0 = QuestionData(question: "", answer: "", open: false)
        let q1 = QuestionData(question: "제품등록 글을 수정하고 싶어요.", answer: "오른쪽 상단에 책갈피 버튼을 누르면, 본인이 작성한 글의 목록을 볼 수 있습니다.\n 여기서 게시물을 클릭하면 수정이 가능합니다.\n\n", open: false)
        let q2 = QuestionData(question: "원하는 게시물 즐겨찾기 기능", answer: "나중에 다시 보고 싶은 게시물이 있다면 하트버튼을 통해 모아둘 수 있습니다.\n오른쪽 상단의 하트버튼을 누르면 즐겨찾기를 해둔 모든 게시물을 한번에 볼 수 있습니다.\n\n", open: false)
        return [q0, q1, q2]
    }()
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionTableView: UITableView!
    
    
    //MARK: - 생명주기
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        basicView.isHidden = false
        questionView.isHidden = true
        tableViewArray = ivRecordQuestionArray
        titleTableArray = titleArray[0]
        menuCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        questionTableView.dataSource = self
        questionTableView.delegate = self
        
    }
    
}

//MARK: - CollectionView 관련 함수

extension IvSettingUsageVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            basicView.isHidden = false
            questionView.isHidden = true
        } else {
            basicView.isHidden = true
            questionView.isHidden = false
            if indexPath.row == 1 {
                tableViewArray = ivRecordQuestionArray
                titleTableArray = titleArray[0]
            } else if indexPath.row == 2 {
                tableViewArray = homeQuestionArray
                titleTableArray = titleArray[1]
            } else if indexPath.row == 3 {
                tableViewArray = graphQuestionArray
                titleTableArray = titleArray[2]
            } else {
                tableViewArray = exchangeQuestionArray
                titleTableArray = titleArray[3]
            }
            questionTableView.reloadData()
        }
    }
}

extension IvSettingUsageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        menuCell.set(title: menuArray[indexPath.row])
        return menuCell
    }
    
}

//MARK: - TableView관련 함수

extension IvSettingUsageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if tableViewArray[section].open == true {
                return 1 + 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.estimatedRowHeight
        } else {
            if indexPath.row == 0 {
                return 60
            } else {
                return tableView.estimatedRowHeight
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: "SettingIvRecordTtitleCell") as? SettingIvRecordTtitleCell else { return UITableViewCell() }
            titleCell.titleLabel.text = titleTableArray.title
            titleCell.detailLabel.text = titleTableArray.detail
            titleCell.isUserInteractionEnabled = false
            return titleCell
        } else {
            if indexPath.row == 0 {
                let questionCell = tableView.dequeueReusableCell(withIdentifier: "SettingIvRecordQuestionCell") as! SettingIvRecordQuestionCell
                questionCell.questionLabel.text = tableViewArray[indexPath.section].question
                return questionCell
            } else {
                let answerCell = tableView.dequeueReusableCell(withIdentifier: "SettingIvRecordAnswerTableViewCell") as! SettingIvRecordAnswerTableViewCell
                answerCell.answerLabel.text = tableViewArray[indexPath.section].answer
                answerCell.isUserInteractionEnabled = false
                return answerCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingIvRecordQuestionCell else { return }
        guard let index = tableView.indexPath(for: cell) else { return }
        
        if indexPath.section == 0 {
            return
        } else {
            if indexPath.row == index.row {
                if index.row == 0 {
                    if tableViewArray[indexPath.section].open == true {
                        tableViewArray[indexPath.section].open = false
                        cell.arrowImageView.image = UIImage(named: "postUpBtnBack")
                        let section = IndexSet.init(integer: indexPath.section)
                        tableView.reloadSections(section, with: .fade)
                        tableView.scrollToRow(at: IndexPath(item: 0, section: indexPath.section), at: .bottom, animated: true)
                    } else {
                        tableViewArray[indexPath.section].open = true
                        cell.arrowImageView.image = UIImage(named: "postDownBtnBack")
                        let section = IndexSet.init(integer: indexPath.section)
                        tableView.reloadSections(section, with: .fade)
                        tableView.scrollToRow(at: IndexPath(item: 1, section: indexPath.section), at: .bottom, animated: true)
                    }
                }
            }
        }
    }
}

