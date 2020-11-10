//
//  InventoryGraphHomeService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct InventoryGraphHomeService {
     static let shared = InventoryGraphHomeService()
    
        func loadHome(completion: @escaping (NetworkResult<Any>)-> Void){
            let token = UserDefaults.standard.string(forKey: "token") ?? ""
            print("yayaya",token)
            let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
            let dataRequest = Alamofire.request(APIConstants.inventoryGraphHomeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{
                response in
                switch response.result {
                case .success:
                    print("성공이다마")
                    guard let statusCode = response.response?.statusCode else {return}
                    guard let value = response.result.value else {return}
                
                    let networkResult = self.judge(by: statusCode, value)
                    completion(networkResult)
                    
                case .failure: completion(.networkFail)
                }
            }
        }
        
        
        private func judge(by statusCode:Int, _ data:Data) -> NetworkResult<Any> {
            switch statusCode {
            case 200:
                print("00000")
                return decodingHome(by : data)
            case 400:
                print("11111")
                return .pathErr
            case 500:
                print("121212")
                return .serverErr
            default:
                print("333333")
                return .networkFail
                
            }
        }
    
        private func decodingHome(by data:Data) -> NetworkResult<Any> {
            print("999999")
            let decoder = JSONDecoder()
            print("00909090909")
            guard let decodedData = try? decoder.decode(InventoryGraphHomeData.self, from: data) else {
                print("sksksk")
                return .pathErr
                
            }
    
            guard let homegraphInfo = decodedData.data else {
                print("klklkl")
                return .requestErr(decodedData.message)}
    
            print("231313141")
            return .success(homegraphInfo)
        }
    }

