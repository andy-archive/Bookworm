//
//  KakaoBook.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/04.
//

import Foundation

struct KakaoBook {
    let title: String
    let authors: String
    let publisher: String
    let price: Int
    let summary: String
    let thumbnail: String
    let url: String
    
    var contents: String {
        return "\(publisher)\n정가: \(price)원"
    }
}
