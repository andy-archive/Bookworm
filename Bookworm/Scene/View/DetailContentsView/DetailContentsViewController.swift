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
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }()
    
    private let toolBar = {
        let view = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        return view
    }()
    
    lazy var memoTextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 20)
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 2
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        guard let data = data, let memoText = data.userMemoText else { return }
        
        if memoText.isEmpty || data.userMemoText == nil {
            memoTextView.text = "입력하세요"
            memoTextView.textColor = .placeholderText
        } else {
            memoTextView.text = memoText
            memoTextView.textColor = .black
        }
        
        passValue()
        configureNavigationBar()
        configureToolBar()
        
        view.addSubview(titleLabel)
        view.addSubview(memoTextView)
        view.addSubview(toolBar)
    }
    
    override func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            memoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            memoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            memoTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ])
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    private func backButtonClicked() {
        guard let textView = memoTextView.text else { return }
        
        if textView != data?.userMemoText {
            let alert = UIAlertController(title: "정말로 뒤로 가시겠습니까?", message: "내용이 저장되지 않습니다.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "아니오", style: .cancel)
            let button = UIAlertAction(title: "글쓰기 취소", style: .destructive) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancel)
            alert.addAction(button)
            present(alert, animated: true)
            return
        } else {
            navigationController?.popViewController(animated: false)
        }
    }
    
    @objc
    private func deleteButtonClicked() {
        let alert = UIAlertController(title: "정말로 삭제하겠습니까?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let button = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            
            let realm = try! Realm()
            guard let data = self?.data else { return }
            
            do {
                try realm.write {
                    self?.removeImageFromDocument(fileName: "andy_\(data._id).jpg")
                    realm.delete(data)
                }
                self?.navigationController?.popViewController(animated: false)
            } catch {
                print(error)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }
    
    @objc
    func updateButtonClicked() {
        guard let data = data else { return }
        guard let textView = memoTextView.text else { return }
        
        if textView.isEmpty {
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
            navigationController?.popViewController(animated: true)
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    private func passValue() {
        guard let data = data else { return }
        titleLabel.text = data.title
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
        
        toolBar.items = [deleteButton, spacer, updateButton]
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
