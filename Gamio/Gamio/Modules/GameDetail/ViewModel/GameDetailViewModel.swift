//
//  GameDetailViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import Foundation
protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    func fetchGameDetail(id: Int)
    func getGameImageUrl() -> URL?
    func getAdditionalImageUrl() -> URL?
    func getGameName() -> String
    func getDescription() -> String
    func getMetacritic() -> Int
    func getReleasedDate() -> String
    func getRating() -> Double
    func getGenres() -> [GameDetailModel.Genre]
}
protocol GameDetailViewModelDelegate: AnyObject {
    func gameDetailLoaded()
}
class GameDetailViewModel: GameDetailViewModelProtocol {
    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    func fetchGameDetail(id: Int) {
        GameDBClient.getGameDetail(gameId: id) { [weak self] gameDetail, error in
            guard let self = self else { return }
            self.game = gameDetail
            self.delegate?.gameDetailLoaded()
        }
    }
    func getAdditionalImageUrl() -> URL? {
        URL(string: game?.imgAdditional ?? "")
    }
    func getGameImageUrl() -> URL? {
        URL(string: game?.img ?? "")
    }
    func getGameId() -> Int32 {
        game?.id ?? 0
    }
    func getGameName() -> String {
        game?.name ?? ""
    }
    
    func getDescription() -> String {
        game?.description ?? "Not Found"
    }
    
    func getMetacritic() -> Int {
        game?.metacritic ?? 0
    }

    func getReleasedDate() -> String {
        game?.released ?? "Not Found"
    }

    func getRating() -> Double {
        game?.rating ?? 0
    }
    
    func getGenres() -> [GameDetailModel.Genre] {
        game?.genres ?? []
    }
    

}
