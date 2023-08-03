//
//  PopContentsTableViewCell.swift
//  Bookworm
//
//  Created by Andy Lee on 2023/08/02.
//

import UIKit

class PopContentsTableViewCell: UITableViewCell {
    
    static let identifier = "PopContentsTableViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        bookTitleLabel.textColor = .black
        bookAuthorLabel.font = UIFont.systemFont(ofSize: 12)
        bookAuthorLabel.textColor = .systemGray2
    }
    
    func configureCell(row: Book) {
        bookImageView.image = row.image
        bookTitleLabel.text = row.title
        bookAuthorLabel.text = row.author
    }

}
