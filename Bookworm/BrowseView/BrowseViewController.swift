//
//  CatalogViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    @IBOutlet weak var popContentsTableView: UITableView!
    
    var bookInfo = BookInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        popContentsTableView.delegate = self
        popContentsTableView.dataSource = self
        
        let historyNib = UINib(nibName: HistoryCollectionViewCell.identifier, bundle: nil)
        let popContentsNib = UINib(nibName: PopContentsTableViewCell.identifier, bundle: nil)
        
        historyCollectionView.register(historyNib, forCellWithReuseIdentifier: HistoryCollectionViewCell.identifier)
        popContentsTableView.register(popContentsNib, forCellReuseIdentifier: PopContentsTableViewCell.identifier)
        
        configureHistoryCollectionViewLayout()
        configurePopContentsTableViewLayout()
    }
    
    func configureHistoryCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        historyCollectionView.collectionViewLayout = layout
    }
    
    func configurePopContentsTableViewLayout() {
        popContentsTableView.rowHeight = 120
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as? HistoryCollectionViewCell else {
            print("ERROR")
            return UICollectionViewCell()
        }
        
        let row = bookInfo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else {
            print("ERROR")
            return
        }
        
        vc.bookIndex = bookInfo.list[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookInfo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopContentsTableViewCell.identifier, for: indexPath) as? PopContentsTableViewCell else {
            print("ERROR")
            return UITableViewCell()
        }
        let row = bookInfo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else {
            print("ERROR")
            return
        }
        
        vc.bookIndex = bookInfo.list[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }

}
