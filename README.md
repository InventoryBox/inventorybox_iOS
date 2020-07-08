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

* 프로젝트 기간: 2020.06.13 ~ 2020.07.18

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
| TTGTagCollectionView | 태그 생성 | 1.11.1 |
| BEMCheckBox | CheckBox 생성 |  |
| SSCustomSideMenu | Side Menu 생성 |  |



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
| 로그인/회원가입 | 1 | 로그인 | - | [지은](https://github.com/hwangJi) |
|  | 1 | 회원가입 | - | [지은](https://github.com/hwangJi) |
|  | 1 | 비밀번호 인증 | - | [지은](https://github.com/hwangJi) |
|  | 1 | 약관동의 | - | [지은](https://github.com/hwangJi) |
| | 3 | 아이디/비밀번호 찾기 | - | - |
| 홈(발주 알림) | 1 | 프로필 | - | [황호](https://github.com/Hwangho) |
|  | 1 | 발주 알림 요약 박스 | - | [황호](https://github.com/Hwangho) |
|  | 2 | 발주 알림 그래프 뷰 | - | [황호](https://github.com/Hwangho) |
| | 1 | 발주 알림 메모 수정 | - | [황호](https://github.com/Hwangho) |
|  | 3 | 더보기 (hamburger menu) | - | [황호](https://github.com/Hwangho) |
| | 3 | 알림 설정 | - | - |
| | 3 | 개인 정보 변경 | - | - |
| 재고기록 | 1 | Top DatePicker Custom | - | [재용](https://github.com/wody98) |
|  | 1 | 오늘 재고 기록 | - | [재용](https://github.com/wody98) |
|  | 1 | 카테고리 필터 | - | [재용](https://github.com/wody98) |
|  | 1 | 재료 추가 | - | [재용](https://github.com/wody98) |
|  | 1 | 기록 수정 | - | [재용](https://github.com/wody98) |
| | 3 | 맨 위로 가기 버튼 | - | [재용](https://github.com/wody98) |
|  | 3 | 카테고리 편집(수정, 이동, 추가, 삭제) | - | [재용](https://github.com/wody98) |
| 재고량 추이 | 1 | Top DatePicker Custom | -- | [지은](https://github.com/hwangJi) |
| | 1 | 카테고리 필터 | - | [지은](https://github.com/hwangJi) |
| | 1 | 날짜별 재고 추이량 Graph View | - | [지은](https://github.com/hwangJi) |
| | 1 | 주차별 재고 추이량 비교 Graph View | - | [지은](https://github.com/hwangJi) |
| | 1 | 재고 기본 설정 변경 | - | [지은](https://github.com/hwangJi) |
| 재고 교환 | 2.5 | 가게 위치 설정 | - | [재용](https://github.com/wody98) |
|  | 3 | 제품등록 목록 | - | [재용](https://github.com/wody98) |
|  | 3 | 내가 찜한 제품 모아보기 | - | - |
|  | 2.5 | 제품 검색 | - | - |
|  | 3 | 제품 필터 | - | - |
| | 2.5 | 제품 등록 | - | - |

 

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

1. Home View

<img src="https://user-images.githubusercontent.com/56102421/86916497-a5256780-c15e-11ea-8e5e-e3d2013b7f9c.png" width ="30%" > 

2. Inventory Record View

<img src="https://user-images.githubusercontent.com/56102421/86916554-bb332800-c15e-11ea-8521-43cc77e2ac51.png" width="30%">  <img src="https://user-images.githubusercontent.com/56102421/86916563-bcfceb80-c15e-11ea-8774-79e72f8f1596.png" width="30%" >  <img scr="https://user-images.githubusercontent.com/56102421/86916566-be2e1880-c15e-11ea-8720-42ad8b7f7fcd.png" width="30%" >  <img src ="https://user-images.githubusercontent.com/56102421/86916568-bf5f4580-c15e-11ea-8593-b88871b73472.png" width="30%">  

3. Inventory Graph View

<img src="https://user-images.githubusercontent.com/56102421/86916577-c25a3600-c15e-11ea-8de0-3a1c57d17624.png" width="30%" >  

## ✏️ 어려운 기능 설명 및 새롭게 알게된 것 설명

----

## 🍎 iOS Developer

<img src="https://user-images.githubusercontent.com/56102421/86921053-8080be00-c165-11ea-8ed9-b2899165d05e.jpeg" width="15%"> 

* [지은](https://github.com/hwangJi)

> 한마디

<img src="https://user-images.githubusercontent.com/56102421/86921589-5380db00-c166-11ea-8f42-8e350c167def.jpeg" width="15%" >  

* [재용](https://github.com/wody98)

> Sopt 26기 iOS 파트 이재용입니다! 한마디

<img src="https://user-images.githubusercontent.com/56102421/86921264-cfc6ee80-c165-11ea-8de9-6115510bc3d5.jpeg" width="15%"> 

- [황호](https://github.com/Hwangho)

> 한마디



