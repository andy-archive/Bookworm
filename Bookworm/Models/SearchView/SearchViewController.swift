//
//  SearchViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "검색 화면"
        
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .blue
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}
