//
//  MovieService.swift
//  MovieDemo
//
//  Created by Rystem Asqar on 10/17/24.
//

import Foundation

class MovieService {
    private let trendingMoviesURL = "https://movies-tv-shows-database.p.rapidapi.com/?page=1"
    private let getImageByImdbIdURL = "https://movies-tv-shows-database.p.rapidapi.com/?movieid="
    private let headers = [
        "x-rapidapi-key": "c6f4e0839amshc3fc868341a0e54p1f8fb4jsn2cba823bf4ac",
        "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com"
    ]
    
    func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: trendingMoviesURL) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(response.movieResults))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func fetchMovieImage(by imdbID: String, completion: @escaping (Result<MovieImage, Error>) -> Void) {
        let urlStr = getImageByImdbIdURL + imdbID
        guard let url = URL(string: urlStr) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(MovieImage.self, from: data)
                completion(.success(response))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
}
