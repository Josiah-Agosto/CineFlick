//
//  ImageAPIClient.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol ImageAPIClient {
    var session: URLSession { get }
    // Image Request
    func fetchImage<U: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> U?, completion: @escaping (ImageResult<U, APIError>) -> Void)
}


// Configures the above function
extension ImageAPIClient {
    typealias jsonCompletion = (Decodable?, APIError?) -> Void
    
    private func imageDecodingTask<U: Decodable>(with request: URLRequest, decoderType: U.Type, completionHandler completion: @escaping jsonCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, .requestFailed); return }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericImageModel = try JSONDecoder().decode(decoderType, from: data)
                        completion(genericImageModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    // Adds what is going to be inside fetchImage() when called.
    func fetchImage<U: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> U?, completion: @escaping (ImageResult<U, APIError>) -> Void) {
        let task = imageDecodingTask(with: request, decoderType: U.self) { (json, error) in
            // Changing to Main Queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(ImageResult.failure(error))
                    } else {
                        completion(ImageResult.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    } // fetchImage End
} // Extension End
