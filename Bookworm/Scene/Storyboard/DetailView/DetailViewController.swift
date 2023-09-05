//
//  DetailViewController.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var bookIndex: Book?
    
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookReviewLabel: UILabel!
    @IBOutlet weak var bookSummaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let bookIndex else {
            print("ERROR")
            return
        }
        
        let xmarkImage = UIImage(systemName: "xmark")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: xmarkImage, style: .plain, target: self, action: #selector(returnButtonClicked))
        
        configView(book: bookIndex)
    }
}

extension DetailViewController {
    private func configView(book: Book) {
        topBackView.backgroundColor = .black
        topBackView.layer.opacity = 0.7
        
        bookImageView.image = book.image
        
        bookTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bookTitleLabel.text = book.title
        bookTitleLabel.textColor = .black
        
        bookAuthorLabel.font = UIFont.systemFont(ofSize: 12)
        bookAuthorLabel.text = book.author
        bookAuthorLabel.textColor = .black
        
        bookReviewLabel.font = UIFont.systemFont(ofSize: 12)
        bookReviewLabel.text = "★ \(String(book.rate))점"
        bookReviewLabel.textColor = .red

        bookSummaryLabel.font = UIFont.systemFont(ofSize: 15)
        bookSummaryLabel.text = book.summary
        bookSummaryLabel.textColor = .black
        bookSummaryLabel.textAlignment = .justified
        bookSummaryLabel.numberOfLines = 0
    }
    
    @objc
    func returnButtonClicked() {
        dismiss(animated: true)
    }
}
