//
//  InventoryCompareGraphService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct InventoryCompareGraphService {
    static let shared = InventoryCompareGraphService()
    
    private func makeParameter (_ item:Int,_ year1:Int,_ month1:Int,_ week1:Int,_ year2:Int,_ month2:Int,_ week2:Int ) -> Parameters {
        return ["item": item, "year1": year1, "month1": month1, "week1": week1, "year2": year2, "month2": month2, "week2": week2]
    }
    
    
    
    func loadCompareGraph(_ item:Int,_ year1:Int,_ month1:Int,_ week1:Int,_ year2:Int,_ month2:Int,_ week2:Int, completion: @escaping (NetworkResult<Any>)-> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        print(token)
        let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
        let dataRequest = Alamofire.request(APIConstants.inventoryCompareGraphURL, method: .get, parameters: makeParameter(item,year1,month1,week1,year2,month2,week2), encoding: JSONEncoding.default, headers: header).responseData{
            response in
            switch response.result {
            case .success:
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
            return decodingHome(by : data)
        case 400:
            return .pathErr
        case 500:
            return .serverErr
        default: return .networkFail
        }
    }
    private func decodingHome(by data:Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(InventoryGraphHomeData.self, from: data) else
        {return .pathErr}
        guard let homegraphInfo = decodedData.data else {
            //print("여기")
            return .requestErr(decodedData.message)}
        return .success(homegraphInfo)
    }
}



