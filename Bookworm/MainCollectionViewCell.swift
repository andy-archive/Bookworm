//
//  MainCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    
    func configureCell(row: Book) {
        
        backView.backgroundColor = .systemGray4
        bookTitleLabel.text = row.title
        reviewLabel.text = String(row.rate)
        
        bookTitleLabel.numberOfLines = 0
    }
}
