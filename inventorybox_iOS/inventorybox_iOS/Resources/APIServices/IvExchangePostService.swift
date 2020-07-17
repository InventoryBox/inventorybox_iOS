//
//  IvExchangePostService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvExchangePostService {
    static let shared = IvExchangePostService()
    
  
  
    
    private func makeParameter (_ productImg:String,_ productName:String,_ isFood:Int,_ price:Int,_ quantity:Int,_ expDate:String,_ description:String,_ coverPrice:Int,_ unit:String ) -> Parameters {
        return ["productImg": productImg, "productName": productName, "isFood": isFood, "price": price, "quantity": quantity, "expDate": expDate, "description": description, "coverPrice":coverPrice, "unit":unit]
    }
    
    
    
    func uploadIvExchangePost(_ productImgName:String,_ productImg:UIImage, _ productName:String,_ isFood:Int,_ price:Int,_ quantity:Int,_ expDate:String,_ description:String,_ coverPrice:Int,_ unit:String, completion: @escaping (NetworkResult<Any>)-> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        print(token)
        let header: HTTPHeaders = ["Content-Type":"multipart/form-data","token":token]
        Alamofire.upload(multipartFormData: { multipartFormData in
            let imageData = productImg.jpegData(compressionQuality: 1.0)!
            multipartFormData.append(imageData, withName: "productImg", fileName: productImgName, mimeType: "image/jpeg")
            multipartFormData.append(productName.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"productName")
            multipartFormData.append("\(isFood)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"isFood")
            multipartFormData.append("\(price)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"price")
            multipartFormData.append("\(quantity)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"quantity")
            multipartFormData.append(expDate.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"expDate")
            multipartFormData.append("\(description)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"description")
            multipartFormData.append("\(coverPrice)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"coverPrice")
            multipartFormData.append(unit.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"unit")
            }, usingThreshold: UInt64.init(), to: APIConstants.ivExchangePostURL, method: .post, headers: header, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                print("Hi")
                upload.uploadProgress(closure: { (progress) in
                    print(progress.fractionCompleted)
                })
                upload.responseData { response in
                    guard let statusCode = response.response?.statusCode, let data = response.result.value else { return }
                    let networkResult = self.judge(by: statusCode, data)
                    completion(networkResult)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
            }
        })
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
        guard let decodedData = try? decoder.decode(IvRecordSuccessData.self, from: data) else
        {
            return .pathErr
        }
        print(decodedData.message)
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
}


