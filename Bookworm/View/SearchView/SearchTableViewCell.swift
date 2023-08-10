//
//  SearchTableViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/10.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookContentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookImageView.contentMode = .scaleToFill
        
        bookTitleLabel.font = .boldSystemFont(ofSize: 15)
        bookTitleLabel.numberOfLines = 0
        
        bookAuthorLabel.font = .systemFont(ofSize: 13)
        bookAuthorLabel.numberOfLines = 0
        
        bookContentsLabel.font = .systemFont(ofSize: 13)
        bookContentsLabel.numberOfLines = 0
    }
}
