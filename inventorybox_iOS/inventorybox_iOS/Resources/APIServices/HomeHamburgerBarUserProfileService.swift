//
//  HomeHamburgerService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

// MARK: post service생성 했습니다.
struct HomeHamburgerBarUserProfileService {
    static let shared = HomeHamburgerBarUserProfileService()        // 싱글톤 객체
    
    //
    
    
//     func getHomeHamburgerBarUserProfile(completion: )
    
    // api를 받아옴녀 후처리 하는것 v
    // escaping : completion을 다른곳에서 선언 가능하도록 만들어 주는 명령어
    
    func getHomeHamburgerBarUserProfile(completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        
        let dataRequest = Alamofire.request(APIConstants.ivHomeUserProfileURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        
//        print(makeParameter(data: data))
        // Alamofire내에서 데이터를 잘 받아왔는지 확인하는 Struc
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }    //
                guard let value = dataResponse.result.value else { return }                 // Data
                let networkResult = self.judge(by: statusCode, value)
                
                completion(networkResult)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    
    // 우리가 직접
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return getHomeHamburgerBarUserProfileData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getHomeHamburgerBarUserProfileData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(HomeUserProfileInformation.self, from: data) else { return .pathErr }
        
        // 성공 메시지
        //        print(decodedData.message)
        
        
        print("User 프로필 가져오기 성공")
        
        if decodedData.success {
            return .success(decodedData.data)
        } else {
            return .requestErr(decodedData.data)
        }
        
    }
    
}

