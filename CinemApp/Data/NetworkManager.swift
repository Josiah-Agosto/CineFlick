//
//  Data.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

// Api URL with Key

class NetworkManager {
    static func fetchJSONResults(completionHandler: @escaping(Results?, Error?) -> Void) -> Void {
        let privateKey: String = apiKey
        let apiURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(privateKey)&language=en-US&page=1")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: apiURL) { (data, response, error) in
            guard let data = data else {
                print("Error recieving URL!")
                return
            }
            if let error = error {
                completionHandler(nil, error)
            }
            do {
                
            } catch {
                print("Error recieving Session, \(error.localizedDescription)")
                completionHandler(nil, error)
            }
        }
        dataTask.resume()
    } // Func End
} // Class End

// do {
//let results = try JSONDecoder().decode(Results.self, from: data)
//completionHandler(results, nil)
//} catch {
//    print("Error recieving Session, \(error.localizedDescription)")
//    completionHandler(nil, error)
//}
