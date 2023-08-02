//
//  CatalogViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/02.
//

import UIKit

class CatalogViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    var book = BookInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        let nib = UINib(nibName: CatalogCollectionViewCell.identifier, bundle: nil)
        historyCollectionView.register(nib, forCellWithReuseIdentifier: CatalogCollectionViewCell.identifier)
        
        configureHistoryCollectionViewLayout()
    }
    
    func configureHistoryCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        historyCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.identifier, for: indexPath) as? CatalogCollectionViewCell else {
            print("ERROR")
            return UICollectionViewCell()
        }
        let row = book.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        
        return cell
    }

}
