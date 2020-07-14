//
//  APIConstants.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://ec2-13-209-128-238.ap-northeast-2.compute.amazonaws.com:3000/"
    
    static let kakaoURL = "https://dapi.kakao.com/v2/local/search/address.json"
    //로그인
    static let loginURL = baseURL + "auth/signin"
    //재고기록 (홈)
    static let inventoryRecordHomeURL = baseURL + "record/home/:date"
    //재고기록 (재료추가_홈)
    static let inventortRecordAddURL = baseURL + "record/item-add"
    //재고기록 수정
    static let inventoryRecordEditURL = baseURL + "record/modifyView/:date"
    //오늘 재고 기록하기
    static let inventoryTodayRecordURL = baseURL + "record/today"
    //재고기록 카테고리정보
    static let inventoryRecordCategoryInfoURL = baseURL + "record/folder/category-info"
    //재고기록 (재료추가_저장)
    static let inventoryRecordItmeAddURL = baseURL + "record/item-add"
    //재고기록 (기록수정 & 오늘 재고 기록_완료)
    static let inventoryRecordModifyURL = baseURL + "record/modify"
    //재고기록 (재료 삭제)
    static let inventoryRecordItemDeleteURL = baseURL + "record/item-delete"
    //재고기록 (카테고리 추가)
    static let inventoryRecordCategoryAddURL = baseURL + "record/category-addwody"
    //재고량 추이 홈 
    static let inventoryGraphHomeURL = baseURL + "dashboard"
}

