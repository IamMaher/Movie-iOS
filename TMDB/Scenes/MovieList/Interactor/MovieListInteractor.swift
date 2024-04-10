//
//  MovieListInteractor.swift
//  TMDB
//
//  Created by Eslam Abo El Fetouh on 22/12/2023.
//

import UIKit
import NetworkKit

final class MovieListInteractor {
    
    var presenter: MovieListInteractorOutput?
    private let moviesLoader: DiscoverMoviesLoaderProtocol
    private var currentPage: Int = 1
    private var totalPages: Int = .max 
    private var isFetching: Bool = false
    
    // Computed properties
    public var canLoadMore: Bool {
        currentPage <= totalPages
    }
    
    // MARK: Init
    init(loader: DiscoverMoviesLoaderProtocol) {
        self.moviesLoader = loader
    }
}
extension MovieListInteractor: MovieListPresenterInteractorProtocol {
    // MARK: - Get Movies List
    func fetchMoviesList() {
        guard shouldFetchMoviesList else { return }
        
        isFetching = true
        showLoadingIndicator(true)

        moviesLoader.loadMovies(with: .init(page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.isFetching = false
                self.showLoadingIndicator(false)
            }
            DispatchQueue.main.async {
                self.handleFetchedResult(result)
            }
        }
    }
    
    private func handleFetchMovieResult(result: MovieResponse) {
        
    }
    
    private func mapToEntity(_ model: Movie) -> MovieListEntity {
        .init(title: model.title ?? "",
              releaseDate: model.releaseDate ?? "",
              posterPath: model.posterPath ?? "")
    }
}
// MARK: - Handle Fetch Movies Result
extension MovieListInteractor {
    private var shouldFetchMoviesList: Bool {
        !isFetching && canLoadMore
    }

    private func showLoadingIndicator(_ isVisible: Bool) {
        presenter?.setLoadingIndicatorVisible(isVisible)
    }

    private func handleFetchedResult(_ result: Result<MovieResponse, Error>) {
        switch result {
        case .success(let movieResponse):
            handleSuccessfulFetch(movieResponse)
        case .failure(let error):
            handleFailedFetch(error)
        }
    }

    private func handleSuccessfulFetch(_ movieResponse: MovieResponse) {
        currentPage = (movieResponse.page ?? currentPage) + 1
        let moviesEntities = movieResponse.results?.compactMap { mapToEntity($0) }
        presenter?.didFetchMovies(moviesEntities ?? [])
    }

    private func handleFailedFetch(_ error: Error) {
        presenter?.didFailToFetchMovies(with: error)
    }

}
