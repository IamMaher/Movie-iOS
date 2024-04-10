//
//  MovieListPresenter.swift
//  TMDB
//
//  Created by Eslam Abo El Fetouh on 22/12/2023.
//

import UIKit

final class MovieListPresenter: NSObject {
    // MARK: - Properites
    private var view: MovieListControllerProtocol?
    private var interactor: MovieListPresenterInteractorProtocol?
    private var router: MovieListRouterProtocol?
    
    private let movieCellHeightToWidthRatio: CGFloat = 1.47

    // MARK: - Init
    init(view: MovieListControllerProtocol?,
         interactor: MovieListPresenterInteractorProtocol?,
         router: MovieListRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to MovieListPresenterProtocol
extension MovieListPresenter: MovieListPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func calculateCellSize(_ collectionViewWidth: CGFloat,
                            horizontalMargin: CGFloat) -> CGSize {
        // Adjust these values based on your layout requirements
        let itemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = horizontalMargin * 2
        let leftAndRightMargins = horizontalMargin * 2
        
        let totalMargins = leftAndRightMargins + spacingBetweenCells
        
        let availableWidth = collectionViewWidth - totalMargins
        let cellWidth = availableWidth / itemsPerRow
        return CGSize(width: cellWidth, height: cellWidth * movieCellHeightToWidthRatio)
    }
    
    func navigateToMovieDetails(with index: Int) {
        self.router?.navigateToMovieDetails()
    }

}
// MARK: Conform to MovieListInteractorOutputa
extension MovieListPresenter: MovieListInteractorOutput {
}
