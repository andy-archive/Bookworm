//
//  DetailContentsViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/05.
//

import UIKit
import RealmSwift

final class DetailContentsViewController: BaseViewController {
    
    var data: KakaoBookRealm?
    private let realm = try! Realm()
    
    let memoLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var textView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 20)
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        guard let data = data, let memoText = data.userMemoText else { return }
        
        if memoText.isEmpty {
            textView.text = "입력하세요"
            textView.textColor = .placeholderText
        } else {
            textView.text = memoText
            textView.textColor = .black
        }
        
        passValue()
        configureNavigationBar()
        configureToolBar()
        
        view.addSubview(memoLabel)
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            memoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            memoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 12),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    func backButtonClicked() {
        tabBarController?.tabBar.isHidden.toggle()
        navigationController?.isToolbarHidden.toggle()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func deleteButtonClicked() {
        tabBarController?.tabBar.isHidden.toggle()
        navigationController?.isToolbarHidden.toggle()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func updateButtonClicked() {
        
        guard let data = data else { return }
        guard let textView = textView.text else { return }
        
        if textView.count == 0 {
            let alert = UIAlertController(title: "내용이 부족합니다.", message: "1자 이상 입력하세요", preferredStyle: .alert)
            let button = UIAlertAction(title: "확인", style: .default)
            alert.addAction(button)
            present(alert, animated: true)
            return
        }
        
        let item = KakaoBookRealm(value: [
            "_id": data._id,
            "title": data.title,
            "authors": data.authors,
            "publisher": data.publisher,
            "price": data.price,
            "summary": data.summary,
            "thumbnail": data.thumbnail,
            "url": data.url,
            "userMemoText": textView
        ])
        
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
            tabBarController?.tabBar.isHidden.toggle()
            navigationController?.isToolbarHidden.toggle()
            navigationController?.popViewController(animated: true)
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    private func passValue() {
        guard let data = data else { return }
        
        memoLabel.text = data.title
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonClicked)
        )
        
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    private func configureToolBar() {
        
        navigationController?.isToolbarHidden = false
        
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(deleteButtonClicked)
        )
        
        let updateButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(updateButtonClicked)
        )
        
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbarItems = [deleteButton, spacer, updateButton]
    }
}

//MARK: UITextViewDelegate

extension DetailContentsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "입력하세요"
            textView.textColor = .placeholderText
        }
    }

}
