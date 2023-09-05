//
//  BookListCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/04.
//

import UIKit

final class BookListCollectionViewCell: BaseCollectionViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    let bookImage = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray2
        return view
    }()
    
    override func configureCell() {
        
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(bookImage)
    }
    
    override func setConstraints() {
        let spacing = 8
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(spacing)
            make.leading.equalTo(backView.snp.leading).offset(spacing)
            make.trailing.lessThanOrEqualTo(backView.snp.trailing).offset(-spacing)
        }
        
        bookImage.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.bottom).offset(-spacing)
            make.trailing.equalTo(backView.snp.trailing).offset(-spacing)
            make.width.equalTo(backView.snp.width).multipliedBy(0.5)
            make.height.equalTo(backView.snp.height).multipliedBy(0.7)
        }
    }
}
