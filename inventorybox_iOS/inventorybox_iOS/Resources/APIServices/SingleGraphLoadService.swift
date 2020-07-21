//
//  SingleGraphLoadService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct SingleGraphLoadService {
    static let shared = SingleGraphLoadService()
    
    private func makeParameter (_ item:Int,_ year:Int,_ month:Int) -> Parameters {
        return ["item": item, "year": year, "month": month]
    }
    

    func loadCompareGraph(_ item:Int,_ year:Int,_ month:Int, completion: @escaping (NetworkResult<Any>)-> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
//        print(token)
        let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
        
        let url =  APIConstants.baseURL + "dashboard/" + String(item) + "/single?year=" + String(year) + "&month=" + String(month)
        
        print(url)
        let dataRequest = Alamofire.request( url,  method: .get, encoding: JSONEncoding.default, headers: header).responseData{
            response in
            switch response.result {
    
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.result.value else {return}
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
                
            }
        }
    }
    
    
    private func judge(by statusCode:Int, _ data:Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return decodingSingleGraph(by : data)
        case 400:
            return .pathErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    private func decodingSingleGraph(by data:Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        
        guard let decodedData = try? decoder.decode(SingleGraphData.self, from: data) else
        {return .pathErr}
        guard let singleGraphInfo = decodedData.data else {
            return .requestErr(decodedData.message)}
        print(decodedData.message)
        return .success(singleGraphInfo)
    }
}



