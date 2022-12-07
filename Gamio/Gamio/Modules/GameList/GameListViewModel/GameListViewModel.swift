//
//  GameListViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    func fetchGames()
    func getGameCount() -> Int
    func getGame(at index: Int) -> GameModel?
    func getGameById(at index: Int) -> Int?
}

protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class GameListViewModel: GameListViewModelProtocol {
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameModel]?
    
    func fetchGames() {
        MovieDBClient.getGames { [weak self] games, error in
            guard let self = self else { return }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameModel? {
        games?[index]
    }
    
    func getGameById(at index: Int) -> Int? {
        games?[index].id
    }
    
}
