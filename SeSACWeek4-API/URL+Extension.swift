//
//  URL+Extension.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/11.
//

import Foundation

extension URL {  //어디서든 사용된다.
   static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
