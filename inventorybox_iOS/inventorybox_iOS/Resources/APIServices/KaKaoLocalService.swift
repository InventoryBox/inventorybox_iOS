//
//  KaKaoLocalService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct KaKaoLocalService {
    static let shared = KaKaoLocalService()
    
    //    private func addParams(params: String) -> String  {
    //        return APIConstants.kakaoURL
    //    }
    
    func getLocal(query: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = [
            //            "Content-Type": "application/json",
            "Authorization": "KakaoAK f4317781ff42e93707b25d7f6a0db404",
        ]
        
        let parameter: Parameters = [
            "query": "\(query)"
        ]
        
        let dataRequest = Alamofire.request(APIConstants.kakaoURL, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
//                print(data)
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
                
            }
        }
    }
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        
        case 200: return getLocalData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        
        }
    }
    
    private func getLocalData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
//        print("here")
        guard let decodedData = try? decoder.decode(KaKaoLocalData.self, from: data) else { return .pathErr }
//        print(decodedData)
        let temp = decodedData.documents
        //        print(temp)
        
        return .success(temp)
    }
}
