//
//  APIConstants.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://ec2.inventoryboxserver.com/"
    
    static let kakaoURL = "https://dapi.kakao.com/v2/local/search/address.json"
    //로그인
    static let loginURL = baseURL + "auth/signin"
    // 회원가입 이메일 인증
    static let emailURL = baseURL + "auth/email/signup"
    // 회원가입
    static let signupURL = baseURL + "auth/signup"
    // 닉네임 중복 체크
    static let nicknameCheckURL = baseURL + "auth/nickname"
    // 이메일 찾기 이메일 인증
    static let emailChecklURL = baseURL + "auth/email/setpw"
    // 이메일 찾기
    static let findEmailURL = baseURL + "auth/find-email"
    
    // Home
     static let ivHomeURL = baseURL + "item/order" //
    // Home + flag
    static let ivHomeCheckBoxURL = baseURL + "item/flag/" //
    // Home + MemoModify
    static let ivHomeMemoModifyURL = baseURL + "item/order/memo/ios"  //
    // Home + Sidbar
    static let ivHomeUserProfileURL = baseURL + "auth/user/profile"
    // 홈 + 햄버거바 (내가 쓴 게시글)
    static let ivHomeUserPostURL = baseURL + "auth/user/post/ios"
    // 홈 + 햄버거바 (개인 정보 변경하기 Get / Put)
    static let ivHomePrivateInforamtionURL = baseURL + "auth/user/personal"
    // 회원 탈퇴
    static let userOutURL = baseURL + "auth/user"
    // 비밀번호 변경
    static let passwordChangeURL = baseURL + "auth/user/pw"

    //재고기록 (홈)
    static let ivRecordHomeURL = baseURL + "record/home/" // ⭕️
    //재고기록 (재료추가_홈)
    static let inventortRecordAddURL = baseURL + "record/item-add"
    //재고기록 수정
    static let inventoryRecordEditURL = baseURL + "record/modifyView/" // ⭕️
    //오늘 재고 기록하기
    static let inventoryTodayRecordURL = baseURL + "record/today" // ⭕️
    //재고기록 카테고리정보
    static let inventoryRecordCategoryInfoURL = baseURL + "record/folder/category-info"
    //재고기록 (재료추가_저장)
    static let inventoryRecordItmeAddURL = baseURL + "record/item-add"
    //재고기록 (기록수정 & 오늘 재고 기록_완료)
    static let inventoryRecordModifyURL = baseURL + "record/modify" // ⭕️ -> 오늘 재고 기록 완료는 테스트 불가여서 오류처리 아직 안함
    //재고기록 (재료 삭제)
    static let inventoryRecordItemDeleteURL = baseURL + "record/item-delete/"
    //재고기록 (카테고리 추가)
    static let inventoryRecordCategoryAddURL = baseURL + "record/category-add"
    //재고기록 (카테고리 이동)
    static let inventoryRecordCategoryMoveURL = baseURL + "record/category-move"
    //재고기록 (카테고리 삭제)
    static let inventoryRecordCategoryDeleteURL = baseURL + "record/category-delete/"
    //재고량 추이 홈 
    static let inventoryGraphHomeURL = baseURL + "dashboard"
    //재고량 추이 선택적 그래프
    static let inventorySingleGraphURL = baseURL + "dashboard/:item/single?year=year&month=month"
    //재고량 추이 한 아이템 주별 비교 그래프
    static let inventoryCompareGraphURL = baseURL + "dashboard/"
    
    static let inventoryExchangeHomeURL = baseURL + "exchange/" // /:filter
    
    //exchange post URL
    static let ivExchangePostURL = baseURL + "exchange/post"
    
    static let ivExchangePostDetailURL = baseURL + "exchange/post/"
    
    static let ivExchangeSearchURL = baseURL + "exchange/search/"
    
    static let ivExchangeUpdateAddress = baseURL + "exchange/modifyLoc"
    
   
}

