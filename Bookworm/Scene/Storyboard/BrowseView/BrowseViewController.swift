//
//  CatalogViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/02.
//

import UIKit

final class BrowseViewController: UIViewController {
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    @IBOutlet weak var popContentsTableView: UITableView!
    
    var bookInfo = BookInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadHistoryCollectionView()
        uploadPopContentsTableView()
        
        configureHistoryCollectionViewLayout()
        configurePopContentsTableViewLayout()
    }
}

// MARK: HistoryCollectionView

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func uploadHistoryCollectionView() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        let historyNib = UINib(nibName: HistoryCollectionViewCell.reuseIdentifier, bundle: nil)
        
        historyCollectionView.register(historyNib, forCellWithReuseIdentifier: HistoryCollectionViewCell.reuseIdentifier)
    }
    
    private func configureHistoryCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        historyCollectionView.collectionViewLayout = layout
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.reuseIdentifier, for: indexPath) as? HistoryCollectionViewCell else {
            print("ERROR")
            return UICollectionViewCell()
        }
        
        let row = bookInfo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else {
            print("ERROR")
            return
        }
        
        vc.bookIndex = bookInfo.list[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
}

// MARK: PopContentsTableView

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
  
    private func uploadPopContentsTableView() {
        popContentsTableView.delegate = self
        popContentsTableView.dataSource = self

        let popContentsNib = UINib(nibName: PopContentsTableViewCell.reuseIdentifier, bundle: nil)
        
        popContentsTableView.register(popContentsNib, forCellReuseIdentifier: PopContentsTableViewCell.reuseIdentifier)
    }
    

    private func configurePopContentsTableViewLayout() {
        popContentsTableView.rowHeight = 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookInfo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopContentsTableViewCell.reuseIdentifier, for: indexPath) as? PopContentsTableViewCell else {
            print("ERROR")
            return UITableViewCell()
        }
        let row = bookInfo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else {
            print("ERROR")
            return
        }
        
        vc.bookIndex = bookInfo.list[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
}
