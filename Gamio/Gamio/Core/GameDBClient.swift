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
    
    static func getGames(completion: @escaping ([GameModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&page_size=1"
        handleResponse(urlString: urlString, responseType: GetPopularGamesResponseModel.self) { responseModel, error in
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
