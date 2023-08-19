//
//  AsyncViewController.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {
    
    @IBOutlet var first: UIImageView!
    @IBOutlet var second: UIImageView!
    @IBOutlet var third: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        first.backgroundColor = .black
        DispatchQueue.main.async {
            self.first.layer.cornerRadius = self.first.frame.width / 2
            
        }
        
        
        
        
    }
    
    //sync async serial concurrent
    //UI Freezing
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        
        let url = URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/nsp-2018_concept_01b-no-text_moon-mars2.jpg")!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.first.image = UIImage(data: data)
            }
        }
        
        
        
    }
    
    
    
    
}
