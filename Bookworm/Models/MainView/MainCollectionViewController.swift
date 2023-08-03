//
//  MainCollectionViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    
    var book = BookInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        setCollectionLayout()
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
        return book.list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            print("ERROR")
            return UICollectionViewCell()
        }
        let row = book.list[indexPath.row]
        
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
        
        vc.bookIndex = book.list[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
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
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        book.list[sender.tag].isFavorite.toggle()
    }
}
