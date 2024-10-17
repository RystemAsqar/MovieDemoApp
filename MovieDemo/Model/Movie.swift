//
//  DataModel.swift
//  MovieDemo
//
//  Created by Rystem Asqar on 10/17/24.
//

import Foundation

// Movie model for trending movies
struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbID = "imdb_id"
    }
}

// Response model for the trending movies API
struct MovieResponse: Codable {
    let movieResults: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
    }
}
