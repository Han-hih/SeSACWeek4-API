//
//  VideoViewController.swift
//  SeSACWeek4-API
//
//  Created by 황인호 on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

//struct video {
//    let author: String
//    let date: String
//    let time: Int
//    let thumbnail: String
//    let title: String
//    let link: String
//
//    var contents: String {
//            return "\(author) | \(time)회\n\(date)"
//    }
//}

class VideoViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    var videoList: [Document] = []
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 140
        
        searchBar.delegate = self
        callRequest(query: "아이유", page: 1)
    }
    
    func callRequest(query: String, page: Int) {
        
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { value in
            print("+++++++++\(value)")
            
            self.isEnd = value.meta.isEnd
            for item in value.documents {
                let author = item.author
                let date = item.datetime
                let time = item.playTime
                let thumbnail = item.thumbnail
                let title = item.title
                let link = item.url
                self.videoList.append(Document(author: author, datetime: date, playTime: time, thumbnail: thumbnail, title: title, url: link))
            }
            self.tableView.reloadData()
            
        }
        //        AF  .request(url, method: .get, headers: header)
        //            .validate(statusCode: 200...500)
        //            .responseJSON { response in
        //
        //                switch response.result {
        //            case .success(let value):
        //                let json = JSON(value)
        //                print("JSON: \(json)")
        //                    print(response.response?.statusCode)
        //
        //                    let statusCode = response.response?.statusCode ?? 500
        //
        //                    if statusCode == 200 {
        //
        //                        self.isEnd = json["meta"]["is_end"].boolValue
        //                        for item in json["documents"].arrayValue {
        //                            let title = item["title"].stringValue
        //                            let author = item["author"].stringValue
        //                            let date = item["datetime"].stringValue
        //                            let thumbnail = item["thumbnail"].stringValue
        //                            let count = item["play_time"].intValue
        //                            let link = item["url"].stringValue
        //
        //                            let data = video(author: author, date: date, time: count, thumbnail: thumbnail, title: title, link: link)
        //                            self.videoList.append(data)
        //                        }
        //                        print(self.videoList)
        //                        self.tableView.reloadData()
        //
        //                    } else {
        //                        print("문제가 발생했어요. 잠시 후 다시 시도해 주세요.")
        //                    }
        //
        //
        //
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        //
        //
        //
        //    }
        
    }
}
// UITableViewDataSourcePrefetching: iOS10이상 사용 가능한 프로토콜, cellForRowAt 메서드가 호출되기 전에 미리 호출됨
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능(용량이 커지면 시간이 오래 걸리고 사용자가 불편할 수 있다.)
    // videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    // page count
    //
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    //취소 기능 : 직접 취소하는 기능을 구현해주어야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
        let videoIndex = videoList[indexPath.row]
//        "\(author) | \(time)회\n\(date)"
        cell.titleLabel.text = videoIndex.title
        cell.contentLabel.text = "\(videoIndex.author) | \(videoIndex.playTime)회\n\(videoIndex.datetime)"
        // 영상이나 고화질이미지는 prefetching을 쓰는 것이 더 좋다.
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        
        return cell
    }

}
extension VideoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1 //새로운 검색어이기 때문에 page를 1로 변경
        videoList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
        
    }
    
}
