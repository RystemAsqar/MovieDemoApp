//
//  ViewController.swift
//  MovieDemo
//
//  Created by Rystem Asqar on 10/17/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var movies: [Movie] = []
    private var movieService = MovieService()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 300)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchMovies()
    }
    
}

// MARK: - UICollectionView DataSource and Delegate
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.row]
        movieService.fetchMovieImage(by: movie.imdbID) { result in
            switch result {
            case .success(let movieImage):
                DispatchQueue.main.async {
                    cell.configure(with: movieImage, year: movie.year)
                }
            case .failure(let error):
                print("Failed to fetch image: \(error)")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        print("MovieId: -> \(selectedMovie.imdbID)")
        movieService.fetchMovieDetails(by: "tt33600145") { [weak self] result in
            switch result {
            case .success(let movieDetails):
                DispatchQueue.main.async {
                    let detailVC = MovieDetailViewController()
                    detailVC.movieDetails = movieDetails
                    print(detailVC.movieDetails as Any)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
}

// MARK: - Functions
extension MoviesViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    func fetchMovies() {
        movieService.fetchTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
            }
        }
    }
}
