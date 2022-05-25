//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Abdullah Al Sohel on 5/25/22.
//

import Foundation

class NewsViewModel {
    let title: String?
    let subTitle: String?
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subTitle: String, imageURL: URL?) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}
