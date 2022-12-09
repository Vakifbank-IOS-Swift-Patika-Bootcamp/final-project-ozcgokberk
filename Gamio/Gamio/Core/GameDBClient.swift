//
//  GameDBClient.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
import Alamofire

final class MovieDBClient {
    static let BASE_URL = "https://api.rawg.io/api/"
    static let IMAGE_BASE_URL = "https://media.rawg.io/media/games/"
    static func getGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&page_size=50"
        handleResponse(urlString: urlString, responseType: GetGamesListResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
//    static func getRecentGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
//        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&dates=2022-01-01,2022-12-31"
//        handleResponse(urlString: urlString, responseType: GetPopularGamesResponseModel.self) { responseModel, error in
//            completion(responseModel?.results, error)
//        }
//    }
    
    static func getMostRatedGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&ordering=-ratings_count"
        handleResponse(urlString: urlString, responseType: GetGamesListResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }

    

        
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}
