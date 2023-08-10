//
//  ViewController.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire

struct Movie {
    var title: String
    var release: String
    
}

class ViewController: UIViewController {
    
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        movieTableView.rowHeight = 60
        indicatorView.isHidden = true
        
       
            func callRequest(date: String) {
                indicatorView.startAnimating()
                indicatorView.isHidden = false
                let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
                
                AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                            let movieNm = item["movieNm"].stringValue
                            let openDt = item["openDt"].stringValue
                            self.movieList.append(Movie(title: movieNm, release: openDt))
                        }
                        self.indicatorView.isHidden = true
                        self.indicatorView.stopAnimating()
                        self.movieTableView.reloadData()
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text = movieList[indexPath.row].release
        
        return cell
    }
}
