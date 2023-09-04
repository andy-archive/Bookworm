//
//  HistoryCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/02.
//

import UIKit

final class HistoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    
    func configureCell(row: Book) {
        bookImageView.image = row.image
    }

}
