//
//  DetailApi.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/26/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol DetailApi {
    var session: URLSession { get }
    func getDetail<D: Decodable>(with url: URL, of id: String, decode: @escaping (Decodable) -> D?, completionHandler completion: @escaping (Result<D, APIError>) -> Void)
}



extension DetailApi {
    typealias jsonCompletion = (Decodable?, APIError?) -> Void
    
    private func jsonTask<D: Decodable>(with url: URL, of id: String, with decoder: D.Type, with completion: @escaping jsonCompletion) -> URLSessionDataTask {
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
    
    
    func getDetail<D: Decodable>(with url: URL, of id: String, decode: @escaping (Decodable) -> D?, completionHandler completion: @escaping (Result<D, APIError>) -> Void) {
        let task = jsonTask(with: url, of: id, with: D.self) { (json, error) in
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
