//
//  CatalogCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/08/02.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CatalogCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    func configureCell(row: Book) {
        bookImageView.image = row.image
    }

}
