//
//  MoviesFeed.swift
//  Dolfin
//
//  Created by igor on 28.11.2020.
//

import Foundation

struct MoviesFeed: Codable {
    var Search: [Movies]
}

struct Movies: Codable {
    var Title: String
    var Year: String
    var type: String
    var Poster: String
    
    enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case type = "Type"
        case Poster
    }
}
