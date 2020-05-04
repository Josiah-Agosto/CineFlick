//
//  DetailNetworkManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class DetailNetworkManager {
    // Properties
    static let shared = DetailNetworkManager()
    // Variables
    private var path: [String] = [] { didSet { updater?() } }
    public var fullPath: [String] = [] { didSet { updater?() } }
    public var personIdArray: [String] = [] { didSet { updater?() } }
    // Reference
    private let castClient = CastClient()
    private let configurationManager = ConfigurationManager.shared
    private let group = DispatchGroup()
    private var updater: (() -> ())? = nil
    private let mainRequestOperation = DispatchQueue.global(qos: .default)
    private let finishingOperation = OperationQueue()
    // Delegate
    public weak var castPropertiesDelegate: CastDataSourceProtocol?
    // MARK: - Requests
    public func detailCast(_ id: String, completion: @escaping (Result<Void, APIError>) -> Void) -> Void {
        mainRequestOperation.async {
            self.mainRequest(with: id, completion: completion)
            self.configurationManager.fetchImages()
        }
        finishingOperation.addOperation {
            self.group.wait()
            for path in self.path {
                self.fullPath.append("\(self.configurationManager.secureBaseUrl)\(self.configurationManager.imageSize)\(path)")
            }
            // Notify Queue
            self.group.notify(queue: .main) {
                completion(.success(()))
                self.updater?()
            }
        }
    } // Func End
    
    // MARK: - Main Request
    private func mainRequest(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        group.enter()
        castClient.castRequest(with: id) { (result) in
            switch result {
            case .success(let castFromResult):
                defer { self.group.leave() }
                guard let castArray = castFromResult?.cast else { return }
                self.castPropertiesDelegate?.castCountForSection = castArray.count
                for perCell in castArray {
                    self.castPropertiesDelegate?.name.append(perCell.name ?? "")
                    self.castPropertiesDelegate?.charName.append(perCell.character ?? "")
                    self.path.append(perCell.profile_path ?? "")
                    guard let personId = perCell.id else { return }
                    self.personIdArray.append("\(personId)")
                }
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
    
    /// Actually resets all saved Data
    public func deleteAllSavedData() {
        path = []
        fullPath = []
        castPropertiesDelegate?.castCountForSection = 0
        castPropertiesDelegate?.charName = []
        castPropertiesDelegate?.name = []
    }
    
} // Class End
