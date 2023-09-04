//
//  BaseCollectionViewCell.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/04.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {}
    
    func setConstraints() {}
}
