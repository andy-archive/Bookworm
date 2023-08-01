//
//  MainCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    func configureCell(row: Book) {
        backView.layer.cornerRadius = 5
        backView.backgroundColor = .systemGray4
        
        bookTitleLabel.text = row.title
        bookTitleLabel.backgroundColor = .clear
        bookTitleLabel.numberOfLines = 0
        
        reviewLabel.text = String(row.rate)
        reviewLabel.backgroundColor = .clear
        
        bookImageView.image = row.image
        bookImageView.layer.cornerRadius = 5
        bookImageView.backgroundColor = .clear
        
        if row.isFavorite == true {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func getRandomColor() -> UIColor{
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
