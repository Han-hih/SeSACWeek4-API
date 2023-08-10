//
//  TranslationViewController.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/10.
//

import UIKit
import SwiftyJSON
import Alamofire

class TranslationViewController: UIViewController {

    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var translateTextView: UITextView!
    
    @IBOutlet var detectLanguage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func requestButtonTapped(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
            let parameters: Parameters = [
                "source": "\(getSource())",   // 여기를 변경
                "target": "en",
                "text": originalTextView.text ?? ""
            ]
            //escaping closure
                AF.request(url, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    let data = json["message"]["result"]["translatedText"].stringValue
                    self.translateTextView.text = data
                case .failure(let error):
                    print(error)
                }
            }
            
        }
}
