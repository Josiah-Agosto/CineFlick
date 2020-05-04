//
//  IdClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/2/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol IdClientProtocol {
    var session: URLSession { get }
    func fetchData<Y: Decodable>(with request: URL, decode: @escaping (Decodable) -> Y?, completion: @escaping (Result<Y, APIError>) -> Void)
}



extension IdClientProtocol {
    typealias jsonCompletion = (Decodable?, APIError?) -> Void
    
    private func jsonDecodingTask<Y: Decodable>(with request: URLRequest, decodingType: Y.Type, completionHandler completion: @escaping jsonCompletion) -> URLSessionDataTask {
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
    
    
    func fetchData<Y: Decodable>(with request: URL, decode: @escaping (Decodable) -> Y?, completion: @escaping (Result<Y, APIError>) -> Void) {
        let task = jsonDecodingTask(with: URLRequest(url: request), decodingType: Y.self) { (json, error) in
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
}
