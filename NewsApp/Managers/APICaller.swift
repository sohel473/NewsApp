//
//  APICaller.swift
//  NewsApp
//
//  Created by Abdullah Al Sohel on 5/21/22.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    private let API_KEY = "b2c3877ecff348019cfa2aa1a4f5ef4e"
    private let baseURL = "https://newsapi.org/v2/top-headlines?"
    
    //MARK: - Get News
    
    func getNews(completion: @escaping(Result<[News], Error>) -> Void) {
        
        let endpoint = "\(baseURL)country=us&pageSize=100&apiKey=\(API_KEY)"
//        print(endpoint)
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data,
                  error == nil else {
                print("Error fetching data")
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data)
                let results = try JSONDecoder().decode(NewsResponse.self, from: data)
//                print(results.articles)
                completion(.success(results.articles))
            } catch {
//                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func searchNews(with query: String, completion: @escaping(Result<[News], Error>) -> Void) {
        
//        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
//            print("Error in query")
//            return
//        }
//        print(query)
        let endpoint = "\(baseURL)apiKey=\(API_KEY)&q=\(query)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data,
                  error == nil else {
                print("Error fetching data")
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data)
                let results = try JSONDecoder().decode(NewsResponse.self, from: data)
                print(results.articles)
                completion(.success(results.articles))
            } catch {
//                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
