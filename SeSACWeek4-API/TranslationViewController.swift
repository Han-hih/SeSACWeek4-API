//
//  TranslationViewController.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/10.
//

import UIKit
import SwiftyJSON
import Alamofire

class TranslationViewController: UIViewController {  //PropertyWrapper
    
    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var translateTextView: UITextView!
    
    @IBOutlet var detectLanguage: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalTextView.text = UserdefualtHelper.standard.nickname
        
        UserdefualtHelper.standard.nickname = "칙촉" //set의 뉴밸류에 들어가게 된다.
        
        UserDefaults.standard.set("고래밥", forKey: "nickname")
        UserDefaults.standard.set(33, forKey: "age")
        
        UserDefaults.standard.string(forKey: "nickname")
        UserDefaults.standard.integer(forKey: "age")
        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        
        
        
    }
    
    func getSource() -> String {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        let parameters: Parameters = [
            "query": originalTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let langcode = json["langCode"].stringValue
                self.detectLanguage.text = langcode
                
            case .failure(let error):
                print(error)
                
            }
        }
        return detectLanguage.text ?? ""
    }
    // 라이브러리가 해야할 일을 다른 파일에서 해줘서 현재 파일에서 import를 안해줘도 된다.
    @IBAction func requestButtonTapped(_ sender: UIButton) {
        TranslateAPIManager.shared.callRequest(text: originalTextView.text ?? "") { result in
            self.translateTextView.text = result
        }
    }
}
