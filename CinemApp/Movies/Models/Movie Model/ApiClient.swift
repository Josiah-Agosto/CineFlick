//
//  APINetworkManager.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    // Complicated looking request
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}


// The last part ot making the request to the Server
extension APIClient {
    typealias jsonCompletion = (Decodable?, APIError?) -> Void
    // Ultimate Function to parse data.
    private func jsonDecodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping jsonCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, .requestFailed); return }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
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
    
    // Initiating the protocol function before being used.
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = jsonDecodingTask(with: request, decodingType: T.self) { (json , error) in
            // Changing to Main Queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
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
    } // Fetch Func End
} // Extension End
