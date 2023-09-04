//
//  MainCollectionViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit
import RealmSwift

final class MainCollectionViewController: UICollectionViewController {
    
    private var bookInfo = BookInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var searchList = [Book]()
    private var searchBar = UISearchBar() {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "검색어를 입력하세요"
            searchBar.showsCancelButton = true
            navigationItem.titleView = searchBar
        }
    }
    
    private var tasks: Results<KakaoBookRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBookRealm()
        configureCollectionViewCell()
        collectionView.collectionViewLayout = .setCollectionViewLayout(numberOfItem: 2, sectionSpacing: 4, itemSpacing: 8)
        
        //searchList = bookInfo.list
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc
    func likeButtonClicked(_ sender: UIButton) {
        
        let title = searchList[sender.tag].title
        
        for (index, book) in bookInfo.list.enumerated() {
            if book.title == title {
                bookInfo.list[index].isFavorite.toggle()
            }
        }
        searchList[sender.tag].isFavorite.toggle()
        collectionView.reloadData()
    }
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: SearchViewController.reuseIdentifier) as? SearchViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    //MARK: UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return searchList.count
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.reuseIdentifier, for: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        
        let row = tasks[indexPath.row]
        guard let thumbnail = row.thumbnail else { return UICollectionViewCell() }
        guard let url = URL(string: thumbnail) else { return UICollectionViewCell() }
        
        cell.titleLabel.text = row.title
        cell.bookImage.loadImage(url: url)
        
        //let row = searchList[indexPath.row]
        //cell.configureCell(row: row)
        //cell.likeButton.tag = indexPath.row
        //cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else { return }
//        vc.bookIndex = searchList[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
}

// MARK: UISearchBar

extension MainCollectionViewController: UISearchBarDelegate {
    
    private func searchQuery(query: String) {
        searchList.removeAll()
        
        for book in bookInfo.list {
            if book.title.contains(query) {
                searchList.append(book)
            }
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchQuery(query: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList = bookInfo.list
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        
        searchQuery(query: text)
    }
}

// MARK: UICollectionView Register & Layout

extension MainCollectionViewController {
    
    private func configureCollectionViewCell() {
        collectionView.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.reuseIdentifier)
        //let nib = UINib(nibName: MainCollectionViewCell.reuseIdentifier, bundle: nil)
        //collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
    }
}

// MARK: setBookRealm

extension MainCollectionViewController {
    private func setBookRealm() {
        let realm = try! Realm()
        tasks = realm.objects(KakaoBookRealm.self)
    }
}
