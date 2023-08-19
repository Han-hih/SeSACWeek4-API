//
//  UserdefualtHelper.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/11.
//

import Foundation

class UserdefualtHelper {
    // 인스턴스를 스택이아닌 데이터에 저장
    static let standard = UserdefualtHelper() // 싱글톤 패턴 초기화가 한번만 일어난다.
    private init() { } //접근 제어자(다음주)
        
    
    
    let userDefaults = UserDefaults.standard
    
    
    
    //클래스 안에 있으면 여러 파일에 영향을 안 미쳐서 처리과정 시간이 줄어든다.
    enum Key: String { //컴파일 최적화
        case nickname, age
    }
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
             return userDefaults.set(newValue, forKey: Key.nickname.rawValue)}
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            return userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
}
