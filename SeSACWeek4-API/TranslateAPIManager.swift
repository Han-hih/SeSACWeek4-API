//
//  TranslateAPIManager.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/11.
//

import UIKit
import SwiftyJSON
import Alamofire

class TranslateAPIManager {
    
    static let shared = TranslateAPIManager()
    
    private init() { }
    
    func callRequest(text: String, resultString: @escaping (String) -> Void ) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        
            let parameters: Parameters = [
                "source": "ko",   // 여기를 변경
                "target": "en",
                "text": text
            ]
            
            //escaping closure
            AF.request(url, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    let data = json["message"]["result"]["translatedText"].stringValue
                    resultString(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
