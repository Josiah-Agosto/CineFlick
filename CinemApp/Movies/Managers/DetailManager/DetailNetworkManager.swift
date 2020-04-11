//
//  DetailNetworkManager.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailNetworkManager {
    // Propterties
    static let shared = DetailNetworkManager()
    // Variables
    var path: [String] = []
    var fullPath: [String] = []
    // Image Variables
    private var secureUrl: String = ""
    private var sizeUrl: String = ""
    private var imageHolder: [UIImage] = []
    // Reference
    private let imageReference: UIImageView = UIImageView()
    private let castClient = CastClient()
    private let imageClient = ImageClient()
    private let group = DispatchGroup()
    private let operation = OperationQueue()
    private let finishingOperation = OperationQueue()
    // Delegate, Contains Cell Count, PersonName, CharacterName and UIImage
    public weak var castPropertiesDelegate: CastDataSourceProtocol?
    
    // MARK: - Requests
    /// Organizes data from Api
    public func detailCast(_ id: String, completion: @escaping () -> Void) -> Void {
        operation.addOperation {
            self.group.enter()
            self.castClient.castRequest(with: id) { (result) in
                switch result {
                case .success(let castFromResult):
                    guard let castArray = castFromResult?.cast else { return }
                    self.castPropertiesDelegate?.castCountForSection = castArray.count
                    for perCell in castArray {
                        self.castPropertiesDelegate?.name.append(perCell.name ?? "")
                        self.castPropertiesDelegate?.charName.append(perCell.character ?? "")
                        self.path.append(perCell.profile_path ?? "")
                    }
                    self.imageClient.createImage(from: .configure, completion: { (result) in
                        switch result {
                        case .success(let imageFromCast):
                            guard let imageCreation = imageFromCast?.images else { return }
                            guard let secure = imageCreation.secure_base_url else { return }
                            guard let size = imageCreation.poster_sizes?[3] else { return }
                            self.secureUrl = secure
                            self.sizeUrl = size
                            self.group.leave()
                        case .failure(let error):
                            print(error)
                        }
                    })
                case .failure(let error):
                    print(error)
                }
            } // Request End
        }
        
        finishingOperation.addOperation {
            self.group.wait()
            self.group.notify(queue: .global()) {
                for path in self.path {
                    self.fullPath.append("\(self.secureUrl)\(self.sizeUrl)\(path)")
                }
                for url in self.fullPath {
                    self.imageHolder.append(self.imageReference.convertUrlToImage(with: url))
                }
                for image in self.imageHolder {
                    self.castPropertiesDelegate?.profileImage.append(image)
                }
                print(self.fullPath)
                print(self.imageHolder)
                completion()
            }
        }
    } // Func End
    
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
        print(path)
        print(fullPath)
        print(secureUrl)
        print(sizeUrl)
        print(imageHolder)
        print(castPropertiesDelegate?.castCountForSection)
        print(castPropertiesDelegate?.charName)
        print(castPropertiesDelegate?.name)
        print(castPropertiesDelegate?.profileImage)
    }
    
} // Class End
