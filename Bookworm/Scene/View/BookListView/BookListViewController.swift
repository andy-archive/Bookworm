//
//  BookListViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/06.
//

import UIKit
import RealmSwift

final class BookListViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .setCollectionViewLayout(numberOfItem: 2, sectionSpacing: 4, itemSpacing: 8))
        view.delegate = self
        view.dataSource = self
        view.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.reuseIdentifier)
        return view
    }()

    private let realm = try! Realm()
    private var tasks: Results<KakaoBookRealm>!
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setBookRealm()
        
        guard let fileURL = realm.configuration.fileURL else { return }
        print(fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc
    private func searchButtonClicked() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SearchViewController.reuseIdentifier) as? SearchViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    private func configureNavigationBar() {
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonClicked)
        )
        navigationItem.setRightBarButton(searchButton, animated: true)
        
    }
}

// MARK: UICollectionView

extension BookListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.reuseIdentifier, for: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        
        let row = tasks[indexPath.row]
        
        guard let thumbnail = row.thumbnail else { return UICollectionViewCell() }
        guard let url = URL(string: thumbnail) else { return UICollectionViewCell() }
        
        cell.titleLabel.text = row.title
        cell.bookImage.loadImage(url: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailContentsViewController()
        vc.data = tasks[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: setBookRealm

extension BookListViewController {
    private func setBookRealm() {
        tasks = realm.objects(KakaoBookRealm.self)
    }
}
