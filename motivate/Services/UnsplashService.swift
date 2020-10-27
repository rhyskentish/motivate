//
//  UnsplashService.swift
//  motivate
//
//  Created by Rhys Kentish on 27/10/2020.
//

import Foundation

let baseUnsplashURL = "https://api.unsplash.com/"

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noData
}

class UnsplashService {
    
    func getRandomPhoto(url: String = baseUnsplashURL + "/photos/random", completion: @escaping (Result<UnsplashImage, NetworkError>) -> Void) {
        guard let unsplashUrl = URL(string: url) else {
              completion(.failure(.invalidURL))
              return
        }
        var urlRequest = URLRequest(url:unsplashUrl)
        urlRequest.setValue("Client-ID YOUR_TOKEN", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            let unsplashResponse = try? JSONDecoder().decode(UnsplashImage.self, from: data)
            print(unsplashResponse)
            if let unsplashResponse = unsplashResponse {
                completion(.success(unsplashResponse))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
}
