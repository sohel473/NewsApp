//
//  ViewController.swift
//  NewsApp
//
//  Created by Abdullah Al Sohel on 5/20/22.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    private var viewModels: [NewsViewModel] = [NewsViewModel]()
    private var articles: [News] = [News]()
    
    private let newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.indentifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        view.addSubview(newsTableView)
        fetchData()
    }

    func fetchData() {
        APICaller.shared.getNews { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let articles):
                self.articles = articles
                self.viewModels = articles.compactMap({ news in
                    NewsViewModel(title: news.title ?? "No Title", subTitle: news.description ?? "No Description yet", imageURL: URL(string: news.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.indentifier, for: indexPath) as! NewsTableViewCell
        let viewModel = viewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article_url = articles[indexPath.row].url else {
            print("No URL for this news")
            return
        }
        guard let url = URL(string: article_url) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}