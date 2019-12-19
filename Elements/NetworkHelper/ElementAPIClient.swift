//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Margiett Gil on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    
    static func postElementAPI (postElements: Element,
                            completion: @escaping (Result<Bool, AppError>) -> ()) {
        let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        //MARK: Create a URL from the endpoint String
        guard let url = URL(string: elementEndpointURL) else {
            completion(.failure(.badURL(elementEndpointURL)))
            return
        }
        //MARK: converting to data
        do {
            let data = try JSONEncoder().encode(postElements)
            
            //MARK: Confirgure out URLRequest
           // type of url
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            request.httpMethod = "POST"
            
            //MARK: Execute POST request
            // either our completion captures Data or AppError
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    static func getElements(for faves: [Element],
                         completion: @escaping(Result <[Element], AppError>) -> ()) {
        let idEndpointUrl = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: idEndpointUrl) else {
            completion(.failure(.badURL(idEndpointUrl)))
            
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let elementAPI = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elementAPI))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    static func postFave(favoriteElementPost: Element,
                             completion: @escaping (Result<Bool, AppError>) -> ()){
        
        let elementEndpointUrl = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: elementEndpointUrl) else {
            completion(.failure(.badURL(elementEndpointUrl)))
            return
        }
        do {
            let data = try JSONEncoder().encode(favoriteElementPost)
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            request.httpMethod = "POST"
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
        }
}

