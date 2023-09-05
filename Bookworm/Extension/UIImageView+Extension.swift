//
//  UIImageView+Extension.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/04.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
