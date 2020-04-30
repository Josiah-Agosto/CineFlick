//
//  ImageAPIClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol ImageAPIClient {
    var session: URLSession { get }
    func fetchImage<I: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> I?, completion: @escaping (Result<I, APIError>) -> Void)
}


// Configures the above function
extension ImageAPIClient {
    typealias jsonCompletion = (Decodable?, APIError?) -> Void
    
    private func imageDecodingTask<I: Decodable>(with request: URLRequest, decoderType: I.Type, completionHandler completion: @escaping jsonCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, .requestFailed); return }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericImageModel = try JSONDecoder().decode(decoderType, from: data)
                        completion(genericImageModel, nil)
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
    

    func fetchImage<I: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> I?, completion: @escaping (Result<I, APIError>) -> Void) {
        let task = imageDecodingTask(with: request, decoderType: I.self) { (json, error) in
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
    } // fetchImage End
} // Extension End
