# 📦 개인 외식 사업자를 위한 재고관리 서비스, 재고창고 📦

<img style="border: 1px solid black !important; border-radius:20px; " src="https://user-images.githubusercontent.com/63707317/86824314-f1be6380-c0c8-11ea-8893-e5856316f338.png" width="200px" />

> <b>'나만의 다이어리를 관리하듯 매일매일 쉽게 기록하고 성장할 수 있는 재고관리 플랫폼', 재고창고입니다. </b><br/>
> 발주시점을 놓치지 않게 도와주는 발주 알림 기능, 데이터를 쉽게 축적할 수 있는 재고 기록 기능이 있습니다. 
> 또한，재고교환 기능을 통해 재고가 떨어지는 갑작스러운 상황에도 개인 사업자들간 네트워크 형성을 통해 재고를 보충할 수 있습니다.
>  <br>

## 📃 목차

- [Project 설명]()
- [개발 환경 및 라이브러리](🛠-개발-환경-및-사용한-라이브러리)
- [Coding Convention]()
- [Github mangement]()
- [간단한 화면 설명]()
- [어려운 기능 설명 및 새롭게 알게된 것 설명]()
- [팀원 소개]()



## 🔍 Project

* <b> SOPT 26th APPJAM 
* 프로젝트 기간: 2020.06.28 ~ 2020.07.18
* 재고창고는 나만의 다이어리를 써가듯 매일매일 쉽게 기록하고 관리할 수 있는 재고 관리 어플리케이션입니다.

<img style="border: 1px solid black !important; border-radius:20px; " src="https://user-images.githubusercontent.com/63707317/86822421-92f7ea80-c0c6-11ea-965f-0d14951ce44e.png" width="600px" />

#### AutoLayout
- iPhone 11 pro
- iPhone 8
- iPhone SE



## 🛠 개발 환경 및 사용한 라이브러리 (Development Environment and Using Library)

### Development Environment

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg) [![Creative Commons License](https://img.shields.io/badge/license-CC--BY--4.0-blue.svg)](http://creativecommons.org/licenses/by/4.0/) <img src="https://camo.githubusercontent.com/068f624eb1aea7290293a41532983b1519da346d/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f694f532d31332e332d6c6967687467726579"> <img src="https://camo.githubusercontent.com/09ed72f0fef2987a6ea9ddb10106cd2a14d87944/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f58636f64652d31312e332d626c7565"> 



### Using Library  
| 라이브러리(Library) | 목적(Purpose) | 버전(Version) |
|:---|:----------|----|
| Alamofire   | 서버 통신 | 4.8.2 |
| Kingfisher  | 이미지 처리 | 5.0 |
| lottie-ios  | Splash screen | 3.1.8 |
| Charts      | 그래프 생성 | 3.5.0 |
| BEMCheckBox | CheckBox 생성 |  |



## 📝 Coding Convention 

### 폴더구조

* Resources
    * Storyboards
    * APiServices
        * APIConstants
        * NetworkResults
        * Services
* Sources
    *  VCs
    * Cells
        * Xibs
    * Protocols
    * Models
    * Designs

👉 [자세히](https://github.com/InventoryBox/inventorybox_iOS/wiki/InventoryBox_Coding_Convention#주석)

### 네이밍

**클래스 & Struct**

- 클래스이름에는 UpperCamelCase를 사용하자.

- 클래스이름에는 접두사를 붙이지 말자.

  좋은 예 >

  ```swift
  class InventoryCell: UITableViewCell
  ```

  나쁜 예 >

  ```swift
  struct orderCheckCVCInfo { }
  ```

**function & 변수 & 상수**

- 함수와 변수에는 lowerCamelCase를 사용하자.

- 버튼명에는 Btn 약자를 사용하자.

- 모든 IBOutlet에는 해당 클래스명을 뒤에 붙이자

  좋은 예 >

  ```swift
  @IBOutlet weak var floatingTodayRecordBtn: UIButton!
  @IBOutlet weak var firstRegisterView: UIView!
  @IBOutlet weak var inventoryTableView: UITableView!
  ```

  나쁜 예 >

  ```swift
  @IBOutlet weak var ScrollView: UIScrollView!
  @IBOutlet weak var leftcollectionview: UICollectionView!
  @IBOutlet weak var rightcollectionview: UICollectionView!
  @IBOutlet weak var tableview: UITableView!
  ```

### 주석

- `// MARK:` 를 사용해서 연관된 코드를 구분짓자

### 기타

- viewDidLoad() 내에는 Function만 위치시키기
- 반복되는 코드는 Extension이나 Class로 묶기
- 함수끼리 1줄 개행



다음 스타일 Guide를 참고헀음 👉 [Style Guide](https://github.com/InventoryBox/inventorybox_iOS/wiki/InventoryBox_Coding_Convention)



## 👏 기능 소개 (Function Introduction)

| Category | Priority | Function | Implemention | Part |
|:--------|:--------|:--------:|:---------|:--------:|
| 스플래시 | 1 |  | - | [지은](https://github.com/hwangJi) |
| 로그인/회원가입 | 1 | 로그인 | ⭕️ | [지은](https://github.com/hwangJi) |
|  | 1 | 회원가입 | ⭕️ | [지은](https://github.com/hwangJi) |
|  | 1 | 이메일 인증 | - | [황호](https://github.com/Hwangho) |
| 홈(발주 알림) | 1 | 프로필 | ⭕️ | [황호](https://github.com/Hwangho) |
|  | 1 | 발주 알림 요약 박스 | ⭕️ | [황호](https://github.com/Hwangho) |
|  | 2 | 발주 알림 그래프 뷰 | ⭕️ | [황호](https://github.com/Hwangho) |
| | 1 | 발주 알림 메모 수정 | - | [황호](https://github.com/Hwangho) |
|  | 3 | 더보기 (hamburger menu) | ⭕️ | [황호](https://github.com/Hwangho) |
| 재고기록 | 1 | Top DatePicker Custom | ⭕️ | [재용](https://github.com/wody98) |
|  | 1 | 오늘 재고 기록 | ⭕️ | [재용](https://github.com/wody98) |
|  | 1 | 카테고리 필터 | ⭕️ | [재용](https://github.com/wody98) |
|  | 1 | 재료 추가 | ⭕️ | [재용](https://github.com/wody98) |
|  | 1 | 기록 수정 | ⭕️ | [재용](https://github.com/wody98) |
| | 3 | 맨 위로 가기 버튼 | ⭕️ | [재용](https://github.com/wody98) |
|  | 3 | 카테고리 편집(수정, 이동, 추가, 삭제) | 세모(api 부족) | [재용](https://github.com/wody98) |
| 재고량 추이 | 1 | Top DatePicker Custom | ⭕️ | [지은](https://github.com/hwangJi) |
| | 1 | 카테고리 필터 | ⭕️ | [지은](https://github.com/hwangJi) |
| | 1 | 현재 주차 Calendar Function | ⭕️ | [지은](https://github.com/hwangJi) |
| | 1 | 날짜별 재고 추이량 Graph View | ⭕️ | [지은](https://github.com/hwangJi) |
| | 1 | 주차별 재고 추이량 비교 Graph View | ⭕️ | [지은](https://github.com/hwangJi) |
| | 1 | 재고 기본 설정 변경 | ⭕️ | [지은](https://github.com/hwangJi) |
| 재고 교환 | 2.5 | 가게 위치 설정 | ⭕️ | [재용](https://github.com/wody98) |
|  | 3 | 제품등록 목록 | - | [재용](https://github.com/wody98) |
|  | 3 | 내가 찜한 제품 모아보기 | - | - |
|  | 2.5 | 제품 검색 | - | - |
|  | 3 | 제품 필터 | - | - |
| | 2.5 | 제품 등록 | - | [지은](https://github.com/hwangJi) |

 

 ## 💻 Github mangement

**아요창고** 들의 *우당탕탕* WorkFlow : **Gitflow Workflow**

- Master와 Develop 브랜치

  마스터(master): 마스터 브랜치

  개발(develop): 기능들의 통합 브랜치 역할❗️ 이 브랜치에서 기능별로 브랜치를 따 모든 구현이 이루어져요

- Master에 직접적인 commit, push (X)

- 커밋 메세지는 다른 사람들이 봐도 이해할 수 있게 써주세요

- 풀리퀘스트를 통해 코드 리뷰를 해보아요

- 하루에 1번이상 Merge -> 주로 아침에❗️ 이유는 밤에 개발 잘 되는 사람들이므로

<img src="https://camo.githubusercontent.com/5af55d4c184cd61dabf0747bbf9ebc83b358eccb/68747470733a2f2f7761632d63646e2e61746c61737369616e2e636f6d2f64616d2f6a63723a62353235396363652d363234352d343966322d623839622d3938373166396565336661342f30332532302832292e7376673f63646e56657273696f6e3d393133" width="80%">  

   ```
- Master
        ├── dev (Develop)
             ├── HometableView(각 Local Branch)
             ├── IVRecord        
             └── IV@@@
   ```
**각자 자신이 맡은 기능 구현에 성공시! 브랜치 다 쓰고 병합하는 방법**

- 브랜치 만듦

```bash
git branch feature/기능이름
```

- 브랜치 전환

```bash
git checkout feature/기능이름
```

- 코드 변경 (현재 **feature/기능이름** 브랜치)

```bash
git add .
git commit -m "커밋 메세지" -a // 이슈보드 이름대로 커밋
```

- 푸시 (현재 **feature/기능이름** 브랜치)

```bash
git push origin feature/기능이름 브랜치
```

- feature/기능 이름 브랜치에서 할 일 다 헀으면 **develop** 브랜치로 전환

```bash
git checkout develop
```

- 머지 (현재 **develop** 브랜치)

```bash
git merge origin feature/기능이름
```

- 다 쓴 브랜치 삭제 (local) (현재 **develop** 브랜치)

```bash
git branch -d feature/기능이름
```

- 다 쓴 브랜치 삭제 (remote) (현재 **develop** 브랜치)

```bash
git push origin :feature/기능이름
```

- develop pull (현재 **develop** 브랜치)

```bash
git pull origin develop
```

- develop push (현재 **develop** 브랜치)

```bash
git push origin develop
```





## 🏞 간단한 화면 설명

1. 초기 로그인/ 회원가입 



1. Home View

> 당일 발주가 필요한 재료들의 알람이 뜸
>
> 사용자가 직접 체크박스를 이용하여 스스로 발주 여부를 확인가능 
>
> 자세히 버튼을 눌러 5일간의 재고량 추이가 제공되어 사용자가 발주할 개수를 결정하는데 도움이 됨

<img src="https://user-images.githubusercontent.com/56102421/87773455-21eeca80-c85e-11ea-960f-4407710c09fc.png" width ="30%" >   <img src="https://user-images.githubusercontent.com/56102421/87773473-27e4ab80-c85e-11ea-9c57-3eacdf8fee92.png" width ="30%" >   <img src="https://user-images.githubusercontent.com/56102421/87773476-287d4200-c85e-11ea-863a-d7b38ded6d81.png" width="30%">  

2. Inventory Record View

> 당일의 재고량을 쉽게 기록하고 데이터를 축적하는 기능
>
> 재료 추가를 할 때 발주 발주 알림 기준과 발주할 수량 설정 가능

<img src="https://user-images.githubusercontent.com/56102421/87776813-5618ba00-c863-11ea-84e6-656fad223d13.png" width="30%"><img src="https://user-images.githubusercontent.com/56102421/87776834-5b760480-c863-11ea-96cf-38c3d913362c.png" width="30%"><img scr="https://user-images.githubusercontent.com/56102421/86916566-be2e1880-c15e-11ea-8720-42ad8b7f7fcd.png" width="30%" >   <img src ="https://user-images.githubusercontent.com/56102421/87776895-79436980-c863-11ea-8950-4ae44f81d646.png" width="30%">  

3. Inventory Graph View

   > 사용자가 기록한 데이터가 주간 별로 나타나 모든 재료의 재고량 추이를 한눈에 확인 가능
   >
   > 발주알림개수 이하일 때 막대그래프가 노란색으로 표시되고 이 간격을 통해 발주 주기를 파악 가능
   >
   > 주간 별 재고량 비교 기능을 통해 계절 또는 분기에 따른 재고량 차이를 파악 가능
   >
   > 사용자는 이러한 통계치를 바탕으로 발주 알림 개수와 발주할 수량을 조절 가능
   >
   > 

<img src="https://user-images.githubusercontent.com/56102421/87777084-d4755c00-c863-11ea-9bbc-0ad3a1ed7bc8.png" width="30%" >  <img src="https://user-images.githubusercontent.com/56102421/87777071-cfb0a800-c863-11ea-94c5-f75d1d03f0f1.png" width="30%" >   

4. Inventory Exchange View

   > 재고교환은 외식사업자들의 식품 및 공산품 중고거래 플랫폼입니다. 
   >
   > 사용자의 가게 위치를 중심으로 반경 2km 내 가게들과 교류가 가능한 형식의 위치 기반 직거래만을 취급함
   >
   > '전화하기' 기능을 통해 판매자와 직접 연락하여,가게 운영 도중에도 빠르게 거래 가능
   >
   > 

<img src="https://user-images.githubusercontent.com/56102421/87777518-962c6c80-c864-11ea-9e50-46b0ba958b02.png" width="30%">  <img src="https://user-images.githubusercontent.com/56102421/87777503-90cf2200-c864-11ea-97e5-291c85115514.png" width ="30%"> <img src="https://user-images.githubusercontent.com/56102421/87777828-27034800-c865-11ea-8a93-35cde2cf2bda.png" width="30%">   <img src="https://user-images.githubusercontent.com/56102421/87778676-87df5000-c866-11ea-9176-5e5cc3781463.png" width="30%" > 

## ✏️ 어려운 기능 설명 및 새롭게 알게된 것 설명



### 👉 카카오 API 이용해보기

[Kakao Developer 시작하기](https://developers.kakao.com/docs/latest/ko/getting-started/app  ) 문서를 보면서 따라하였다.

키워드로 특정 장소 정보를 조회하거나, 좌표를 주소 또는 행정구역으로 변환하는 등 장소에 대한 정보를 제공하는 카카오 Local API를 사용하였다.

먼저,  AppDelegate에 카카오 SDK를 등록한다.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
  // 카카오 SDK 등록
  KakaoSDKCommon.shared.initSDK(appKey: "") 
  return true
}
```

그 후, 카카오 문서를 읽으며, 데이터 모델을 만든다. 여기서 모델의 타입이나 옵셔널 처리가 하나라도 틀릴 경우, 통신오류가 뜨기 때문에 조심해아한다.

```swift
import Foundation

// MARK: - KaKaoLocalService
struct KaKaoLocalData: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let address: Address?
    let addressName, addressType: String
    let roadAddress: RoadAddress?
    let x, y: String

    enum CodingKeys: String, CodingKey {
        case address
        case addressName = "address_name"
        case addressType = "address_type"
        case roadAddress = "road_address"
        case x, y
    }
}
// 이하 생략 
// 더보고싶으면 코드에 있습니당
```

마지막으로 통신서비스를 만들어준다. 여기서 url에 query문을 넣는 것 때문에 url Type으로 변환하는 점에서 어려움을 겪었다. 아래와 같이 Alamofire의 request함수의 encoding변수를 사용해주어야한다. ⭐️ 이거중요.. 이거때매 멘붕이었음 쿼리문으로 보낼때는 encoding을 query문으로 해주기!

```swift
let parameter: Parameters =  
[ "query": "\(query)" ]
        
let dataRequest = Alamofire.request(APIConstants.kakaoURL, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: header)
        
```



### 👉어떤 객체 안에서 일어나는 일들을 다른 객체에 어떻게 알려줄까? 

우리 어플리케이션의 뷰는 테이블뷰와 콜렉션뷰를 굉장히 많이 사용하였고, 셀, 뷰컨 등 객체들 간의 데이터 넘기기가 중요한 문제였다. 여기서 평소 하던대로 아래와 같이 데이터를 주고 받으면 객체간의 순환참조가 일어나 어플리케이션이 굉장히 꼬이게 된다고 한다.

```swift
let IvRecordAddProductST = UIStoryboard.init(name: "IvRecordAddProduct", bundle: nil)
guard let addProductVC = IvRecordAddProductST.instantiateViewController(identifier: "IvRecordNaviVC") as? IvRecordNaviVC  else { return }
```



- **테이블뷰 셀 안의 버튼(체크박스)이 눌렸다는 것을 뷰컨에 알리는 방법** 

먼저 protocol을 만들어 준다.

```swift
@objc protocol CellButtonDelegate {
    @objc func didClickCheckButton(isClicked: Bool, indexPath: IndexPath)
    @objc func didAllBtnClickedCheckButton(isClicked: Bool, indexPath: Int)
}
```

> CellButtonDelegate를 만들어주고 didClickCheckButton함수를 만들어준다.

다음, Cell 객체에 다음과 같이 변수를 선언해준다.

```swift
class InventoryCategoryEditCell: UITableViewCell {
    static let identifier: String = "InventoryCategoryEditCell"
    
    var delegate: CellButtonDelegate?
    var indexPath: IndexPath?
    var isSelectBtn: Bool = false {
        didSet {
            selectedCheckBox.on = isSelectBtn
        }
    }
```

>Cell 안에 만들어준 protocol을 가진 delegate를 옵셔널로 선언하여 행위를 알려주는 변수를 만들어준다. 
>
>Cell 하나하나는 indexPath에 대한 정보가 없기 때문에 indexPath도 옵셔널로 선언하여 VC에 알려줄 때 정보를 같이 넘겨준다.
>
>체크박스가 눌렸는지 안눌렸는지 트래킹해줄 변수하나도 같이 선언해준다.

다음, Cell 객체 안에 체크박스가 눌렸을 때의 IBAction을 연결하여 그 안에 Delegate함수를 넣어준다.

```swift
@IBAction func turnCheckbox(_ sender: Any) {
        if selectedCheckBox.on {
            isSelectBtn = true
        } else {
            isSelectBtn = false
        } 
        delegate?.didClickCheckButton(isClicked: isSelectBtn, indexPath: indexPath!)
}
```

그리고, VC에 처음에 선언해준 Protocol을 할당하고 위 함수가 실행될 때의 코드를 작성한다.

```swift
extension IvRecordCategoryEditVC: CellButtonDelegate {
    
    func didClickCheckButton(isClicked: Bool, indexPath: Int) {

        if self.checkboxSelections.contains(indexPath) {
            guard let i = self.checkboxSelections.firstIndex(of: indexPath) else { return }
            self.checkboxSelections.remove(at: i)
        } else {
            checkboxSelections.append(indexPath)
        }
        
    }
}
```

> 이렇다면 버튼이 눌렀을 때 delegate가 VC에 버튼이 눌렸다는 것을 함수를 통해 알려주게 된다.

마지막으로, 이걸 가장 많이 까먹는데 delegate와 indexPath가 뭔지 알려줘야한다.

```swift
guard let inventoryCell = tableView.dequeueReusableCell(withIdentifier: InventoryCategoryEditCell.identifier, for: indexPath) as? InventoryCategoryEditCell else { return UITableViewCell() }
            
inventoryCell.delegate = self
inventoryCell.indexPath = indexPath.row - 1
            
return inventoryCell
```



### 👉 PopupView로 Alert창이나 DatePicker 커스텀해보기 (유용하게 씀)

- **DatePicker 커스텀해보기**
- **Alert창을 VC이동으로 만들어보기**

<img src="https://user-images.githubusercontent.com/56102421/87782071-cd068080-c86c-11ea-939a-89795eee34b9.png" width="30%">  <img src="https://user-images.githubusercontent.com/56102421/87782073-ce37ad80-c86c-11ea-8118-0252346ce433.png" width="30%">  

1. VC를 하나 만들고 backgroundColor -> Clear Color 
2. 밑에 UIVIew 하나를 만들고 그 위에 원하는 뷰로 커스텀하기
3. 자연스럽게 백그라운드 뷰가 어두워지게 하는 모션을 위하여 이동전 View에 backgroundPopupView하나를 깔고 alpha를 0으로 주기

이동 전 VC내 코드

```swift
// VC에서 어두워지게 하는 backgroundView 만들기
private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
}
// popupBackgroundView 어두워지는 애니메이션
func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
}
// 다시 VC로 돌아올 때 popupBackgroundView 애니메이션으로 지워주기
@objc func didDisappearPopup(_ notification: Notification) {
        animatePopupBackground(false)
}
// 메모리를 차지하므로 항상 옵저버 지워주기
deinit {
        NotificationCenter.default.removeObserver(self)
}
```

> 노티를 통해 다시 원래 VC로 돌아왔다는 것을 알리고, 어둡게 하는 backgroundView를 숨겨줌
>
> 또한, 노티를 통해 원하는 데이터를 주고받을 수 있음

이동 후 팝업 VC 내 코드

```swift
@IBAction func dismissPopup(_ sender: Any) {
  
        NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["??": ??])      
        self.dismiss(animated: true)
}
```

> 노티를 통해 알려줌











----

## 🍎 iOS Developer

<img src="https://user-images.githubusercontent.com/56102421/86921053-8080be00-c165-11ea-8ed9-b2899165d05e.jpeg" width="15%"> 

* [지은](https://github.com/hwangJi)

> 한마디

<img src="https://user-images.githubusercontent.com/56102421/86921589-5380db00-c166-11ea-8f42-8e350c167def.jpeg" width="15%" >  

* [재용](https://github.com/wody98)

> 다음엔 꼭 폴더링 VC끼리 만들어주자 파일찾기 너무 힘듬 ㅠㅠ 앱잼 화이팅

<img src="https://user-images.githubusercontent.com/56102421/86921264-cfc6ee80-c165-11ea-8de9-6115510bc3d5.jpeg" width="15%"> 

- [황호](https://github.com/Hwangho)

> 한마디



