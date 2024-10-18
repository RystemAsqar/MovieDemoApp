//
//  MovieImageModel.swift
//  MovieDemo
//
//  Created by Rystem Asqar on 10/17/24.
//

import Foundation


struct MovieImage: Codable {
    let title: String
    let imdbID: String
    let poster: String
    let fanart: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case imdbID = "IMDB"
        case poster
        case fanart
    }
}

