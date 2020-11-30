//
//  Movie.swift
//  Dolfin
//
//  Created by igor on 27.11.2020.
//

import Foundation
import UIKit

class Movie {
    var title: String
    var year: String
    var type: String
    var poster: UIImage
    
    init(title: String = String(), year: String = String(), type: String = String(), poster: UIImage = UIImage()) {
        self.title = title
        self.year = year
        self.type = type
        self.poster = poster
    }
}
