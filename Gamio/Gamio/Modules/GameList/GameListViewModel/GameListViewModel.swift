//
//  GameListViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//
//self.games?.sort() { $0.playTime < $1.playTime }
import Foundation
protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    func fetchGames()
    func getLatestGames()
    func getMostRatedGames()
    func getGame(at index: Int) -> GameListModel?
    func getGameById(at index: Int) -> Int?
}

protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded(gamesArray: [GameListModel]?)
    func latesGamesLoaded(latestGames: [GameListModel]?)
    func topRatedGamesLoaded(topRatedGames: [GameListModel]?)
}

final class GameListViewModel: GameListViewModelProtocol {
    
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameListModel]?
    private var latestGames: [GameListModel]?
    private var topRatedGames: [GameListModel]?
    
    func fetchGames() {
        MovieDBClient.getGames { [weak self] games, error in
            guard let self = self else { return }
            self.games = games
            self.delegate?.gamesLoaded(gamesArray: games)
        }
    }
    
    func getMostRatedGames() {
        MovieDBClient.getMostRatedGames { [weak self] topRatedGames, error in
            guard let self = self else { return }
            self.topRatedGames = topRatedGames
            self.delegate?.topRatedGamesLoaded(topRatedGames: topRatedGames)
        }
    }
    
    func getLatestGames() {
        MovieDBClient.getLatestGames { [weak self] latestGames, error in
            guard let self = self else { return }
            self.latestGames = latestGames
            self.delegate?.latesGamesLoaded(latestGames: latestGames)
        }
    }
        
    func getMovieImageURL(at index: Int) -> URL? {
        URL(string: MovieDBClient.IMAGE_BASE_URL + (games?[index].img ?? ""))
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameListModel? {
        games?[index]
    }
    
    func getGameById(at index: Int) -> Int? {
        games?[index].id
    }
}
