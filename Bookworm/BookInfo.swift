//
//  BookInfo.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/07/31.
//

import UIKit

struct BookInfo {
    
    var list: [Book] = [
        Book(title: "프로젝트 헤일메리", rate: 4.5, image: UIImage(named: "프로젝트 헤일메리"), isFavorite: true),
        Book(title: "총, 균, 쇠", rate: 4.8, image: UIImage(named: "총, 균, 쇠"), isFavorite: false),
        Book(title: "지적 대화를 위한 넓고 얕은 지식 1", rate: 4.5, image: UIImage(named: "지적 대화를 위한 넓고 얕은 지식 1"), isFavorite: true),
        Book(title: "하얼빈", rate: 4.5, image: UIImage(named: "하얼빈"), isFavorite: false),
        Book(title: "불편한 편의점", rate: 4.7, image: UIImage(named: "불편한 편의점"), isFavorite: false),
        Book(title: "도파민네이션", rate: 4.4, image: UIImage(named: "도파민네이션"), isFavorite: true),
        Book(title: "물고기는 존재하지 않는다", rate: 4.4, image: UIImage(named: "물고기는 존재하지 않는다"), isFavorite: false),
        Book(title: "사피엔스", rate: 4.7, image: UIImage(named: "사피엔스"), isFavorite: true),
        Book(title: "노르웨이의 숲", rate: 4.5, image: UIImage(named: "노르웨이의 숲"), isFavorite: true),
        Book(title: "마당이 있는 집", rate: 4.5, image: UIImage(named: "마당이 있는 집"), isFavorite: false),
    ]
}
