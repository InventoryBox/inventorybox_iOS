//
//  IvHomeHamburgerUserPostService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/03.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

// MARK: post service생성 했습니다.
struct IvHomeHamburgerUserPostService {
    static let shared = IvHomeHamburgerUserPostService()

    func getHomeUserPost(completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let dataRequest = Alamofire.request(APIConstants.ivHomeUserPostURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
//        print(makeParameter(data: data))
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                
                completion(networkResult)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return getHomeHamburgerUserPostData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getHomeHamburgerUserPostData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(IvHomeUserPostInformation.self, from: data) else { return .pathErr }
        
//         성공 메시지
        print("성공했나유?")
        
        guard let data = decodedData.data else { return .pathErr }
        
        if decodedData.success {
            return .success(data)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}

