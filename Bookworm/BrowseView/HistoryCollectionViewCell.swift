//
//  HistoryCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/02.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "HistoryCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    func configureCell(row: Book) {
        bookImageView.image = row.image
    }

}
