//
//  GameDetailModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import Foundation
struct GameDetailModel: Decodable {
    
    let name: String?
    let description: String?
    let metacritic: Int?
    let released : String?
    let img: String?
    let imgAdditional: String?
    let rating: Double?
    let genres: [Genre]?
    
    struct Genre: Decodable {
        let name : String
    }
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case description
        case metacritic
        case released
        case img = "background_image"
        case imgAdditional = "background_image_additional"
        case rating
        case genres
    }
}
