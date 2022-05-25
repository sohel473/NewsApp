//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Abdullah Al Sohel on 5/25/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let indentifier = "NewsTableViewCell"
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let newsSubtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsSubtitle)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitle.frame = CGRect(x: 10, y: 0, width: contentView.frame.width - 150, height: 70)
        newsSubtitle.frame = CGRect(x: 10, y: 70, width: contentView.frame.width - 150, height: contentView.frame.height / 2)
        newsImageView.frame = CGRect(x: contentView.frame.width-150, y: 5, width: 140, height: contentView.frame.height - 10)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitle.text = nil
        newsSubtitle.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsViewModel) {
        self.newsTitle.text = viewModel.title
        self.newsSubtitle.text = viewModel.subTitle
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else {return}
                guard let data = data, error == nil else {
                    print("Error fetching Image")
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
