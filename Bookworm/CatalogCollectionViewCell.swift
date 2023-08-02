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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(row: Book) {
        bookImageView.image = row.image
    }

}
