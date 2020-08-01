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
| 스플래시 | 1 |  | ⭕️ | [지은](https://github.com/hwangJi) |
| 로그인/회원가입 | 1 | 로그인 | ⭕️ | [지은](https://github.com/hwangJi) |
|  | 1 | 회원가입 | ⭕️ | [황호](https://github.com/Hwangho) |
|  | 1 | 이메일 인증 | ⭕️ | [황호](https://github.com/Hwangho) |
| 홈(발주 알림) | 1 | 프로필 | ⭕️ | [황호](https://github.com/Hwangho) |
|  | 1 | 발주 알림 요약 박스 | ⭕️ | [황호](https://github.com/Hwangho) |
|  | 2 | 발주 알림 그래프 뷰 | ⭕️ | [황호](https://github.com/Hwangho) |
| | 1 | 발주 알림 메모 수정 | ⭕️ | [황호](https://github.com/Hwangho) |
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
|  | 3 | 제품등록 목록 | ⭕️ | [재용](https://github.com/wody98) |
|  | 3 | 내가 찜한 제품 모아보기 | ⭕️ | [재용](https://github.com/wody98) |
|  | 2.5 | 제품 검색 | ⭕️ | [지은](https://github.com/hwangJi) |
|  | 3 | 제품 필터 | ⭕️ | [재용](https://github.com/wody98) |
| | 2.5 | 제품 등록 | ⭕️ | [지은](https://github.com/hwangJi) |

 

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

<img src="https://user-images.githubusercontent.com/56102421/87776813-5618ba00-c863-11ea-84e6-656fad223d13.png" width="30%"><img src="https://user-images.githubusercontent.com/56102421/87776834-5b760480-c863-11ea-96cf-38c3d913362c.png" width="30%">   <img src ="https://user-images.githubusercontent.com/56102421/87776895-79436980-c863-11ea-8950-4ae44f81d646.png" width="30%">  

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

   > 재고교환은 외식사업자들의 식품 및 공산품 중고거래 플랫폼
   >
   > 사용자의 가게 위치를 중심으로 반경 2km 내 가게들과 교류가 가능한 형식의 위치 기반 직거래만을 취급함
   >
   > '전화하기' 기능을 통해 판매자와 직접 연락하여,가게 운영 도중에도 빠르게 거래 가능
   >
   > 

<img src="https://user-images.githubusercontent.com/56102421/87777518-962c6c80-c864-11ea-9e50-46b0ba958b02.png" width="30%">  <img src="https://user-images.githubusercontent.com/56102421/87777503-90cf2200-c864-11ea-97e5-291c85115514.png" width ="30%"> <img src="https://user-images.githubusercontent.com/56102421/87777828-27034800-c865-11ea-8a93-35cde2cf2bda.png" width="30%">   <img src="https://user-images.githubusercontent.com/56102421/87778676-87df5000-c866-11ea-9176-5e5cc3781463.png" width="30%" > 

## ✏️ 어려운 기능 설명 및 새롭게 알게된 것 설명



### [👉 카카오 API 이용해보기](https://github.com/InventoryBox/inventorybox_iOS/wiki/👉-카카오-API-이용해보기)

### [👉어떤 객체 안에서 일어나는 일들을 다른 객체에 어떻게 알려줄까?](https://github.com/InventoryBox/inventorybox_iOS/wiki/👉어떤-객체-안에서-일어나는-일들을-다른-객체에-어떻게-알려줄까%3F)

- **테이블뷰 셀 안의 버튼(체크박스)이 눌렸다는 것을 뷰컨에 알리는 방법** 

### [👉 PopupView로 Alert창이나 DatePicker 커스텀해보기 (유용하게 씀)](https://github.com/InventoryBox/inventorybox_iOS/wiki/👉-PopupView로-Alert창이나-DatePicker-커스텀해보기-(유용하게-씀))

- **DatePicker 커스텀해보기**
- **Alert창을 VC이동으로 만들어보기**

### [👉 우당탕탕 아요 알게된 점 노션 링크](https://www.notion.so/1f54afb3b2404d60a04b96e9c31eec0a) 





----

## 🍎 iOS Developer

<img src="https://user-images.githubusercontent.com/56102421/86921053-8080be00-c165-11ea-8ed9-b2899165d05e.jpeg" width="15%"> 

* [지은](https://github.com/hwangJi-dev)

> 앱잼을 하면서 많은 것을 배웠다. 팀원끼리 소통하는 방법도 새롭게 알게 된 점이 많은 것 같다. 후회가 남는 점이 있다면 iOS 팀원들끼리 서로 소통하고 회고하는 시간을 자주 가졌으면 좋았겠다는 생각이 든다.
>
> 그리고 개발 측면에서도 모르는 것을 파헤치는 과정이 힘들기도 했지만 너무 재미있었다. 앱잼 기간동안 많은 것을 알려주고, 즐겁게 앱잼을 하게 도와준 재용오빠, 황호오빠한테 너무 감사하다는 말을 전하고 싶다! 
>
> 재고창고 iOS 앞으로도 오래오래 보자 ~ ㅎㅎ

<img src="https://user-images.githubusercontent.com/56102421/86921589-5380db00-c166-11ea-8f42-8e350c167def.jpeg" width="15%" >  

* [재용](https://github.com/wody98)

> 우리 팀원들 만나서 너무 행복하고 좋았어~~ 정말로 개발적으로도 사람적⭐️으로도 많이 성장한 앱잼이었다 ㅎㅎㅎ 
>
> 개발하면서 다음엔 꼭 반영하고 싶은게 있다면 폴더링 방법을 VC끼리 만들어주자~!! 파일찾기 너무 힘듬 ㅠㅠ.. 

<img src="https://user-images.githubusercontent.com/56102421/86921264-cfc6ee80-c165-11ea-8de9-6115510bc3d5.jpeg" width="15%"> 

- [황호](https://github.com/Hwangho)

> 3주라는 짧지 않은 시간동안 개발에 대해서 많은것을 알게 되었고 좋은 사람들을 알게 되었습니다.
>
> 앞으로도 더 iOS를 열심히 준비해 봐야겠다~

