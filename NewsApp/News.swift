//
//  News.swift
//  NewsApp
//
//  Created by Abdullah Al Sohel on 5/22/22.
//

import UIKit

struct NewsResponse: Codable {
    let articles: [News]
}

struct News: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let name: String?
}

