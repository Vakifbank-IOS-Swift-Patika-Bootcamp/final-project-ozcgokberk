//
//  GetPopularGamesResponseModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
struct GetPopularGamesResponseModel: Decodable {
    let results: [GameModel]
}
