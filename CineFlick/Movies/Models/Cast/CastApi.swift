//
//  CastApi.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol CastApiProtocol {
    var session: URLSession { get }
    func getCast<C: Decodable>(with url: URL, of id: String, decode: @escaping (Decodable) -> C?, completionHandler completion: @escaping (Result<C, APIError>) -> Void)
}



extension CastApiProtocol {
    typealias completion = (Decodable?, APIError?) -> Void
    
    private func jsonTask<C: Decodable>(with url: URL, of id: String, with decoder: C.Type, with completion: @escaping completion) -> URLSessionDataTask {
        let task = session.dataTask(with: url) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, .requestFailed); return }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let type = try JSONDecoder().decode(decoder, from: data)
                        completion(type, nil)
                    } catch let error {
                        print(error)
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
    
    
    func getCast<C: Decodable>(with url: URL, of id: String, decode: @escaping (Decodable) -> C?, completionHandler completion: @escaping (Result<C, APIError>) -> Void) {
        let task = jsonTask(with: url, of: id, with: C.self) { (json, error) in
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
    }
}
