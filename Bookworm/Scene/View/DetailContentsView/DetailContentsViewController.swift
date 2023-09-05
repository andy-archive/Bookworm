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
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var textView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 20)
        view.text = "내용을 입력하세요"
        view.textColor = .placeholderText
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        tabBarController?.tabBar.isHidden = true
        
        passValue()
        configureNavigationBar()
        configureToolBar()
        
        view.addSubview(titleLabel)
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
    
    @objc
    func backButtonClicked() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.isToolbarHidden = true
        navigationController?.popViewController(animated: false)
    }
    
    @objc
    func deleteButtonClicked() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.isToolbarHidden = true
        navigationController?.popViewController(animated: false)
    }
    
    @objc
    func updateButtonClicked() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.isToolbarHidden = true
        navigationController?.popViewController(animated: false)
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
    
    private func passValue() {
        guard let data = data else { return }
        
        titleLabel.text = data.title
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
            textView.text = "내용을 입력하세요"
            textView.textColor = .placeholderText
        }
    }

}
