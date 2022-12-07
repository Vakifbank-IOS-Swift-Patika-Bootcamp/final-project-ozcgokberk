//
//  GameModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
struct GameModel: Codable {
    let id: Int
    let slug: String
    let name: String
    let img: String
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case img = "background_image"
    }
}
