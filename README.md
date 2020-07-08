# 📦 재고창고
<img style="border: 1px solid black !important; border-radius:20px; " src="https://user-images.githubusercontent.com/63707317/86824314-f1be6380-c0c8-11ea-8893-e5856316f338.png" width="200px" />

###  개인 외식 사업자를 위한 재고관리 Application 📦
<b>'나만의 다이어리를 관리하듯 매일매일 쉽게 기록하고 성장할 수 있는 재고관리 플랫폼', 재고창고입니다. </b><br/>
발주시점을 놓치지 않게 도와주는 발주 알림 기능, 데이터를 쉽게 축적할 수 있는 재고 기록 기능이 있습니다. 
또한，재고교환 기능을 통해 재고가 떨어지는 갑작스러운 상황에도 개인 사업자들간 네트워크 형성을 통해 재고를 보충할 수 있습니다.
 <br>

## 🔍 Project
* <b> SOPT 26th APPJAM 

* 프로젝트 기간: 2020.06.13 ~ 2020.07.18

<img style="border: 1px solid black !important; border-radius:20px; " src="https://user-images.githubusercontent.com/63707317/86822421-92f7ea80-c0c6-11ea-965f-0d14951ce44e.png" width="600px" />

#### AutoLayout
- iPhone 11 pro
- iPhone 8
- iPhone SE

## 🛠 개발 환경 및 사용한 라이브러리 
### 개발 환경
![텍스트](https://camo.githubusercontent.com/6d208dcd48d17aa375fb2d8976f4f0f1ccf7d4bf/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d342e322d6f72616e67652e737667)             ![텍스트](https://camo.githubusercontent.com/cbd34cc87a0faae303cbe4dd9d9b8e160854324e/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6963656e73652d43432d2d42592d2d342e302d626c75652e737667)
##### * Xcode: xcode와 swift를 사용해 개발
##### * Terminal을 통해 협업

### Library  
| 라이브러리 | 목적 |
|:---|:----------| 
| Alamofire   | 서버 통신 | 
| Kingfisher  | 이미지 처리 |
| lottie-ios  | Splash screen | 
| Charts      | 그래프 생성 |
| BEMCheckBox | CheckBox 생성 | 
| SSCustomSideMenu | Side Menu 생성 |

## 📝 Coding Convention 

### 폴더명
* Resources
    * Storyboards
    * APiServices
        * APIConstants
        * NetworkResults
        * 서비스들
* Sources
    *  VCs
    * Cells
        * Xibs
    * Protocols
    * Models
    * Designs


### 네이밍
다음 스타일 Guide를 참조하여 따름
[Coding Convention](https://github.com/InventoryBox/inventorybox_iOS/wiki/InventoryBox_Coding_Convention)

### 기능 소개
| 기능 | 상세 기능 | 담당 |
 |:--------|:--------|:--------:| 
 | 스플레시 | 스플레시 화면 영상 | 이재용 | 
 | 로그인 | 로그인 | 황지은 | 
 | 회원가입 | 이메일 인증 | 황지은 |
 |  | 인증번호 인증 | 황지은 | 
 |  | 비밀번호 인증 | 황지은 | 
 |  | 약관동의 | 황지은 | 
 | 홈 | 재고 목록 | 송황호 | 
 |  | 발주 확인 | 송황호 |
 |  | 체크박스 | 송황호 |
 |  | 더보기 | 송황호 |
 |  | 메모수정 | 송황호 |
 |  | Side Menu View | 송황호 |
 | 재고기록 | 캘린더 | 이재용 |
 |  | Date pickerView Custom| 이재용 |
 |  | 카테고리 분류 | 이재용 |
 |  | 카테고리 필터 | 이재용 |
 |  | 카테고리 수정 | 이재용 |
 |  | 카테고리 추가 | 이재용 |
 |  | 재료 추가 | 이재용 |
 |  | 재료 목록 | 이재용 |
 |  | 카테고리 분류 | 이재용 |
 |  | Check Box | 이재용 |
 |  | Alert Custom | 이재용 |
 |  | Alert Custom tableView| 이재용 |
 |  | Check Box | 이재용 |
 | 재고량 추이 | 캘린더 day 분류 | 황지은 |
 | | 캘린더 Week 분류 | 황지은 |
 | | 카테고리 선택 | 황지은 |
 | | 카테고리 필터 | 황지은 |
 | | Graph | 황지은 |
 | | 캘린더 | 황지은 |
 
 
 
 ## 💻 Github mangement

 ####  Master에 직접적인 commit, push (X)
   
   ```
- Master
        ├── dev (Develop)
             ├── HometableView(각 Local Branch)
             ├── IVRecord        
             └── IV@@@
```
**각자 자신이 맡은 기능 구현에 성공시!**

-  자신의 Branch에 올리기 (충돌시 위험을 최소화 시키기 위해)
    - git checkout (자신의 브랜치) -> git add .  ->  git commit - m " "   ->  git push
    
-   합치고자 하는 Branch를 임의로 생성한 Branch에 받아오기
    - git checkout -b (merge용 브랜치) -> git pull origin (브랜치 이름)
    
-   받아온 Branch와 자신의 Branch를 합치기
    - git checkout (merge용 브랜치) -> git merge (자신의 브랜치)
    
-   merge에 성공 했을 때 dev에 올리기
    - git push orgin dev
    
- 전에 사용했던 브랜치는 삭제 
    - git checkout -d (branch들)
    
-  Branch를 다시 만들고 작업 (기능관련 naming)
    - git checkout -b (작업해야할 기능 관련 브랜치)  ->  git pull origin (dev)








## 간단한 화면 설명

##### 어려운 기능 설명 및 새롭게 알게된 것 설명

----

### 🍎 iOS Developer

* [황지은](https://github.com/hwangJi)
* [이재용](https://github.com/wody98)
* [송황호](https://github.com/Hwangho)



