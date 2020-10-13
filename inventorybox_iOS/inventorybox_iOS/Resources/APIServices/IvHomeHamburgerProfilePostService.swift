//
//  IvHomeHamburgerProfilePostService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvHomeHamburgerProfilePutService {
    static let shared = IvHomeHamburgerProfilePutService()
    
    func changeProfile(nickname:String, img:UIImage, imgName:String, completion: @escaping (NetworkResult<Any>) -> Void){
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        let body: Parameters = [
            "nickname": nickname
        ]
        Alamofire.upload(multipartFormData : {multipartFormData in
            for(key,value) in body{
                let val = value as! String
                multipartFormData.append(val.data(using:String.Encoding.utf8)!,withName:key)
            }
            print(nickname)
            let imageData = img.jpegData(compressionQuality:1.0)!
            multipartFormData.append(imageData,withName:"img", fileName:imgName, mimeType:"image/jpeg")
            print(img)
        }, usingThreshold:UInt64.init(), to: APIConstants.signupURL,method:.post, headers:header,encodingCompletion:{(result) in
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
            print("성공임?")
            return decodingHome(by : data)
        case 400:
            return .pathErr
        case 500:
            print("왜")
            return .serverErr
        default: return .networkFail
        }
    }
    private func decodingHome(by data:Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(SignupData.self, from: data) else
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