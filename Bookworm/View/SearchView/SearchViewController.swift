//
//  SearchViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

struct KakaoBook {
    let title: String
    let authors: String
    let publisher: String
    let price: Int
    let summary: String
    let thumbnail: String
    let url: String
    
    var contents: String {
        return "\(publisher)\n정가: \(price)원"
    }
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var bookTableView: UITableView!
    
    static let identifier = "SearchViewController"
    
    var bookList = [KakaoBook]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "카카오 책 검색"
        
        configureBookTableView()
        configureCloseButton()
    }
    
    func callRequest(query: String) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization": "\(APIKey.kakaoAPI)"]
        
        AF.request(url,
                   method: .get,
                   headers: header
        ).validate(statusCode: 200...300
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                print("JSON: \(json)")
                print("STAUS CODE: \(statusCode)")
                
                if statusCode == 200 {
                    for item in json["documents"].arrayValue {
    //                    print(item)
                        
                        let title = item["title"].stringValue
                        let author = item["authors"][0].stringValue
                        let publisher = item["publisher"].stringValue
                        let price = item["price"].intValue
                        let summary = item["contents"].stringValue
                        let thumbnail = item["thumbnail"].stringValue
                        let url = item["url"].stringValue
                        
                        let data = KakaoBook(
                            title: title,
                            authors: author,
                            publisher: publisher,
                            price: price,
                            summary: summary,
                            thumbnail: thumbnail,
                            url: url
                        )
                        
                        self.bookList.append(data)
                        self.bookTableView.reloadData()
                    }
                } else {
                    print("REQUEST ERROR: \(statusCode)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCloseButton() {
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .blue
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        bookList.removeAll()
        
        guard let text = searchBar.text else { return }
        callRequest(query: text)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureBookTableView() {
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.rowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = bookList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        guard let url = URL(string: row.thumbnail) else { return UITableViewCell() }
        
        cell.bookTitleLabel.text = row.title
        cell.bookAuthorLabel.text = row.authors
        cell.bookContentsLabel.text = row.contents
        cell.bookImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
