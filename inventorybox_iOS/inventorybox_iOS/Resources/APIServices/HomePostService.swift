//
//  HomePostService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

//import Foundation
//import Alamofire
//
//struct IvRecordEditCateService {
//    static let shared = IvRecordEditCateService()
//    
//    func getRecordEditCate(whichDate: String, completion: @escaping (NetworkResult<Any>) -> Void) {
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjEsImVtYWlsIjoicm94YW5lYW1ldGh5QGdtYWlsLmNvbSIsImlhdCI6MTU5NDY0MTQ4M30.oAUMpo6hNxgZ77nYj0bZStOqJLAqJVDMYna93D1NDwo"
//        ]
//        
//        let url = APIConstants.ivRecordHomeURL + whichDate
////        print(url)
//        let dataRequest = Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
//        
//        dataRequest.responseData { (dataResponse) in
//            switch dataResponse.result {
//            case .success:
//                guard let statusCode = dataResponse.response?.statusCode else { return }
//                guard let value = dataResponse.result.value else { return }
//                let networkResult = self.judge(by: statusCode, value)
//                
//                print(statusCode)
//                completion(networkResult)
//            case .failure(let err):
//                print(err.localizedDescription)
//                completion(.networkFail)
//            
//            }
//            
//        }
//    }
//    
//    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        switch statusCode {
//        case 200: return getRecordEditCateData(by: data)
//        case 400: return .pathErr
//        case 500: return .serverErr
//        default: return .networkFail
//        }
//    }
//    
//    private func getRecordEditCateData(by data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//        
//        guard let decodedData = try? decoder.decode(IvRecordEditCateData.self, from: data) else { return .pathErr }
//        guard let data = decodedData.data else { return .pathErr }
//        // 성공 메시지
//        print(decodedData.message)
//        
//        if decodedData.success {
//            return .success(data)
//        } else {
//            return .requestErr(decodedData.message)
//        }
//        
//    }
//    
//}
