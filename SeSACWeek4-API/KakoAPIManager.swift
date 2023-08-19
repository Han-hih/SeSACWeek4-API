//
//  KakoAPIManager.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/11.
//

import UIKit
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": APIKey.kakaoKey]
    
    func callRequest(type: EndPoint, query: String, completionHandler: @escaping (Genre) -> () ) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text //문자열도 덧셈이 가능하다.
        print(url)
        AF
            .request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Genre.self) { data in
                switch data.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                    
                }
            }
    }
}
