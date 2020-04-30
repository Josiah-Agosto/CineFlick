//
//  APIClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<A: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> A?, completion: @escaping (Result<A, APIError>) -> Void)
}



extension APIClient {
    typealias jsonCompletion = (Decodable?, APIError?) -> Void
    
    private func jsonDecodingTask<A: Decodable>(with request: URLRequest, decodingType: A.Type, completionHandler completion: @escaping jsonCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, .requestFailed); return }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .invalidData)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .requestFailed)
            }
        }
        return task
    }
    
    
    func fetch<A: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> A?, completion: @escaping (Result<A, APIError>) -> Void) {
        let task = jsonDecodingTask(with: request, decodingType: A.self) { (json , error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    } // Fetch Func End
} // Extension End
