//
//  IvRecordMoveCateService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/09/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvRecordMoveCateService {
    static let shared = IvRecordMoveCateService()
    
    private func makeParameter(itemIdx: [Int], cateIdx: Int) -> Parameters {
        var parsingParameter: [[String: Int]] = []
        for idx in itemIdx {
            let item = [
                "itemIdx" : idx,
                "categoryIdx": cateIdx
            ]
            parsingParameter.append(item)
        }
        
        return ["itemInfo": parsingParameter]
    }
    
    func getRecordEditIvPost(selectedIdx: [Int], categoryIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let dataRequest = Alamofire.request(APIConstants.inventoryRecordCategoryMoveURL, method: .put, parameters: makeParameter(itemIdx: selectedIdx, cateIdx: categoryIdx), encoding: JSONEncoding.default, headers: header)
        
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
        case 200: return getRecordEditIvPostData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
            
        }
    }
    
    private func getRecordEditIvPostData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(IvRecordSuccessData.self, from: data) else { return .pathErr }
        
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}

