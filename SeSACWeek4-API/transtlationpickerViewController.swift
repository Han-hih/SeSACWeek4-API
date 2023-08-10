//
//  transtlationpickerViewController.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/10.
//

import UIKit

class transtlationpickerViewController: UIViewController {
    
    
    @IBOutlet var currentLanguage: UITextField!
    @IBOutlet var currentText: UITextView!
    
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var resultLanguage: UITextField!
    @IBOutlet var resultText: UITextView!
    
    var languagePicker = UIPickerView()
    var resultLanguagePicker = UIPickerView()
    
    let languageList: [(english: String, korean: String)] = [
        ("ko", "한국어"),
        ("en", "영어"),
        ("ja", "일본어"),
        ("zh-CN", "중국어 간체"),
        ("zh-TW", "중국어 번체"),
        ("vi", "베트남어"),
        ("id", "인도네시아어"),
        ("th", "태국어"),
        ("de", "독일어"),
        ("ru", "러시아어"),
        ("es", "스페인어"),
        ("it", "이탈리아어"),
        ("fr", "프랑스어")
    ]
    var currentLang = ""
    var resultLang = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePicker.delegate = self
        languagePicker.dataSource = self
        resultLanguagePicker.delegate = self
        resultLanguagePicker.delegate = self
        setUI()
        textFieldinputPickerView()
    }
    
    func textFieldinputPickerView() {
        currentLanguage.inputView = languagePicker
        resultLanguage.inputView = resultLanguagePicker
    }
    
    func setUI() {
        currentLanguage.placeholder = "현재 언어"
        resultLanguage.placeholder = "번역할 언어"
        
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


extension transtlationpickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentLanguage.isEditing {
            currentLanguage.text = languageList[row].korean
            currentLang = languageList[row].english
            print(currentLang)
        } else {
            resultLanguage.text = languageList[row].korean
            resultLang = languageList[row].english
            print(resultLang)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageList[row].korean
    }
    
    
}
