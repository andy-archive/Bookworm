//
//  MainCollectionViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    
    var bookInfo = BookInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()
    var searchList = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchList = bookInfo.list
        
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        configureSearchBar()
        setCollectionLayout()
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else {
            print("ERROR")
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            print("ERROR")
            return UICollectionViewCell()
        }
        let row = searchList[indexPath.row]
        
        cell.configureCell(row: row)
        
        cell.likeButton.tag = indexPath.row

        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            print("ERROR")
            return
        }
        
        vc.bookIndex = searchList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: SearchBar

extension MainCollectionViewController: UISearchBarDelegate {
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
    }
    
    func searchQuery(data: String) {
        searchList.removeAll()
        
        for book in bookInfo.list {
            if book.title.contains(data) {
                searchList.append(book)
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let data = searchBar.text else { return }
        
        searchQuery(data: data)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList = bookInfo.list
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let data = searchBar.text else { return }
        
        searchQuery(data: data)
    }
}

extension MainCollectionViewController {
    func setCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - spacing * 3
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
}
