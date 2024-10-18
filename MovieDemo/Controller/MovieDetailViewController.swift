//
//  MovieDetailViewController.swift
//  MovieDemo
//
//  Created by Rystem Asqar on 10/18/24.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    
    var movieDetails: MovieDetails?
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        if let details = movieDetails {
            configure(with: details)
        }
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(ratingLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func configure(with details: MovieDetails) {
        titleLabel.text = details.title ?? "No Title Available"
        descriptionLabel.text = details.description ?? "No Description Available"
        ratingLabel.text = "Rating: \(details.imdbRating ?? "N/A")"
    }
}
