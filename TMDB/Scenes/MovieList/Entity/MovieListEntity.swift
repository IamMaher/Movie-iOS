//
//  MovieListEntity.swift
//  TMDB
//
//  Created by Eslam Abo El Fetouh on 22/12/2023.
//

import Foundation
import UIComponents

final class MovieListEntity {
    let id: Int
    let title: String
    let releaseDate: String
    private let posterPath: String
        
    // MARK: Init
    init(id: Int,
         title: String,
         releaseDate: String,
         posterPath: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
    }
}
// MARK: Conform to MovieCellItemProtocol to Display Cell Details
extension MovieListEntity: MovieCellItemProtocol {
    var imagePath: String {
        ImagePathBuilder.buildImagePath(posterPath: posterPath)
    }
    
    var subtitle: String {
        releaseDate
    }
}
// MARK: Conform to MovieDetailsBuilderInput to pass data to MovieDetails 
extension MovieListEntity: MovieDetailsBuilderInput {
}
