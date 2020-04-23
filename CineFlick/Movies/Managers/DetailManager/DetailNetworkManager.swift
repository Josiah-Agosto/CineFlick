//
//  DetailNetworkManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailNetworkManager {
    // Properties
    static let shared = DetailNetworkManager()
    // Variables
    private var path: [String] = []
    var fullPath: [String] = [] { didSet { updater?() } }
    // Image Variables
    private var secureUrl: String = ""
    private var sizeUrl: String = ""
    private var imageHolder: [UIImage] = []
    // Reference
    private let imageReference = CustomImageView()
    private let castClient = CastClient()
    private let imageClient = ImageClient()
    private let group = DispatchGroup()
    private var updater: (() -> ())? = nil
    private let operation = OperationQueue()
    private let finishingOperation = OperationQueue()
    // Delegate
    public weak var castPropertiesDelegate: CastDataSourceProtocol?
    // MARK: Requests
    public func detailCast(_ id: String, completion: @escaping (Result<Void, APIError>) -> Void) -> Void {
        mainRequest(with: id, completion: completion)
        requestImageInfo()
        finishingOperation.addOperation {
            self.group.wait()
            for path in self.path {
                self.fullPath.append("\(self.secureUrl)\(self.sizeUrl)\(path)")
            }
            for image in self.imageHolder {
                self.castPropertiesDelegate?.profileImage.append(image)
            }
            // Notify Queue
            self.group.notify(queue: .main) {
                completion(.success(()))
                self.updater?()
            }
        }
    } // Func End
    
    // MARK: Main Request
    private func mainRequest(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        group.enter()
        print(id)
        self.castClient.castRequest(with: id) { (result) in
            switch result {
            case .success(let castFromResult):
                defer { self.group.leave() }
                guard let castArray = castFromResult?.cast else { return }
                self.castPropertiesDelegate?.castCountForSection = castArray.count
                for perCell in castArray {
                    self.castPropertiesDelegate?.name.append(perCell.name ?? "")
                    self.castPropertiesDelegate?.charName.append(perCell.character ?? "")
                    self.path.append(perCell.profile_path ?? "")
                }
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        } // Request End
    }
    
    // MARK: Image Request
    private func requestImageInfo() {
        group.enter()
        self.imageClient.createImage(from: .configure, completion: { (result) in
            switch result {
            case .success(let imageFromCast):
                defer { self.group.leave() }
                guard let imageCreation = imageFromCast?.images else { return }
                guard let secure = imageCreation.secure_base_url else { return }
                guard let size = imageCreation.poster_sizes?[3] else { return }
                self.secureUrl = secure
                self.sizeUrl = size
            case .failure(let error):
                print(error)
            }
        })
    }
    
    /// Actually resets all saved Data
    public func deleteAllSavedData() {
        path = []
        fullPath = []
        secureUrl = ""
        sizeUrl = ""
        imageHolder = []
        castPropertiesDelegate?.castCountForSection = 0
        castPropertiesDelegate?.charName = []
        castPropertiesDelegate?.name = []
        castPropertiesDelegate?.profileImage = []
    }
    
} // Class End
