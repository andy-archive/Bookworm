//
//  MainCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookReviewLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 5
        backView.backgroundColor = .systemGray4
        
        bookTitleLabel.font = .boldSystemFont(ofSize: 18)
        bookTitleLabel.backgroundColor = .clear
        bookTitleLabel.numberOfLines = 0
        
        bookReviewLabel.font = UIFont.systemFont(ofSize: 12)
        bookReviewLabel.textColor = .red
        bookReviewLabel.backgroundColor = .clear
        
        bookImageView.layer.cornerRadius = 5
        bookImageView.backgroundColor = .clear
    }
    
    func configureCell(row: Book) {
        
        bookTitleLabel.text = row.title
        bookReviewLabel.text = "★ \(String(row.rate))"
        bookImageView.image = row.image

        let heartFillImage = UIImage(systemName: "heart.fill")
        let heartNotFillImage = UIImage(systemName: "heart")
        
        if row.isFavorite == true {
            likeButton.setImage(heartFillImage, for: .normal)
        } else {
            likeButton.setImage(heartNotFillImage, for: .normal)
        }
        
        likeButton.tintColor = .systemPink
    }
    
    func getRandomColor() -> UIColor{
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
