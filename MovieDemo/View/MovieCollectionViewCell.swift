//
//  MovieTableViewCell.swift
//  MovieDemo
//
//  Created by Rystem Asqar on 10/17/24.
//

import UIKit
import SnapKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    private let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:    -Functions
extension MovieCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
    }
    func setupConstraints() {
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(contentView.frame.width * 1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configure(with movieImage: MovieImage, year: String) {
        if let posterURL = URL(string: movieImage.poster) {
            moviePosterImageView.sd_setImage(with: posterURL, completed: nil)
        }
        titleLabel.text = movieImage.title
        yearLabel.text = year
    }
}
