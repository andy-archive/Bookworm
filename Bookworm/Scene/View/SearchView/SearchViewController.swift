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
import RealmSwift

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var bookTableView: UITableView! {
        didSet {
            bookTableView.delegate = self
            bookTableView.dataSource = self
        }
    }
    
    var bookList = [KakaoBook]()
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "카카오 책 검색"
        bookTableView.rowHeight = 100
        
        configureCloseButton()
    }
    
    private func callRequest(query: String) {
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
                
                if statusCode == 200 {
                    for item in json["documents"].arrayValue {
                        
                        let title = item["title"].stringValue
                        let author = item["authors"][0].stringValue
                        let publisher = item["publisher"].stringValue
                        let price = item["price"].stringValue
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
    
    private func configureCloseButton() {
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .blue
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
}

//MARK: UISearchBar

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        bookList.removeAll()
        
        guard let text = searchBar.text else { return }
        callRequest(query: text)
    }
}

//MARK: UITableView

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = bookList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as? SearchTableViewCell else { return UITableViewCell() }
        cell.bookTitleLabel.text = row.title
        cell.bookAuthorLabel.text = row.authors
        cell.bookContentsLabel.text = row.contents
        
        guard let url = URL(string: row.thumbnail) else { return UITableViewCell() }
        cell.bookImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = bookList[indexPath.row]
        
        let task = KakaoBookRealm(
            title: row.title,
            authors: row.authors,
            publisher: row.publisher,
            price: row.price,
            summary: row.summary,
            thumbnail: row.thumbnail,
            url: row.url,
            userMemoText: ""
        )
        
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            print("ERROR")
        }
        
        DispatchQueue.global().async {
            
            guard let url = URL(string: row.thumbnail) else { return }
            
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let bookImage = UIImage(data: data) {
                        self.saveImageToDocument(fileName: "andy_\(task._id).jpg", image: bookImage)
                    }
                }
            } catch {
                print("ERROR")
            }
        }
        
        dismiss(animated: true)
    }
    
}
