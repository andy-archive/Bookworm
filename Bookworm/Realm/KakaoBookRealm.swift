//
//  KakaoBookRealm.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/04.
//

import Foundation
import RealmSwift

final class KakaoBookRealm: Object {
    
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    
    @Persisted var title: String
    @Persisted var authors: String
    @Persisted var publisher: String
    @Persisted var price: String
    @Persisted var summary: String?
    @Persisted var thumbnail: String?
    @Persisted var url: String?
    @Persisted var isFavorite: Bool
    @Persisted var userMemoText: String?
    
    convenience init(_id: String = UUID().uuidString, title: String, authors: String, publisher: String, price: String, summary: String? = nil, thumbnail: String? = nil, url: String? = nil, userMemoText: String? = nil) {
        self.init()
        
        self._id = _id
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.price = price
        self.summary = summary
        self.thumbnail = thumbnail
        self.url = url
        self.isFavorite = false
        self.userMemoText = ""
    }
}
