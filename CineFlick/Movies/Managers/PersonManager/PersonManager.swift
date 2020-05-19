//
//  PersonManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

final class PersonManager {
    // References / Properties
    static let shared = PersonManager()
    private lazy var personClient = PersonClient()
    private lazy var configurationManager = ConfigurationManager.shared
    private let dateReference = Date()
    private let group = DispatchGroup()
    private var updater: (() -> ())? = nil
    // Public Variables
    public var personName: String = "" { didSet { updater?() } }
    public var personImageUrl: String = "" { didSet { updater?() } }
    public var personBirthdate: String = "" { didSet { updater?() } }
    public var personBirthPlace: String = "" { didSet { updater?() } }
    public var personProfession: String = "" { didSet { updater?() } }
    public var personBiography: String = "" { didSet { updater?() } }
    
    // MARK: - Person Request
    public func personRequest(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            self.group.enter()
            self.personClient.getPersonInfo(with: id) { (result) in
                switch result {
                case .success(let personData):
                    defer { self.group.leave(); completion(.success(())); self.updater?() }
                    guard let person = personData else { completion(.failure(.invalidData)); return }
                    guard let birthdate = person.birthday else { return }
                    guard let placeOfBirth = person.place_of_birth else { return }
                    guard let personFilePath = person.profile_path else { return }
                    let personAge = self.dateReference.convertDateToAge(date: birthdate)
                    self.personName = person.name
                    self.personBirthdate = "\(birthdate) - \(personAge) Years Old"
                    self.personBirthPlace = placeOfBirth
                    self.personProfession = person.known_for_department
                    self.personBiography = person.biography
                    let fullImagePath = "\(self.configurationManager.secureBaseUrl)\(self.configurationManager.imageSize)\(personFilePath)"
                    print(fullImagePath)
                    self.personImageUrl = fullImagePath
                case .failure(_):
                    completion(.failure(.requestFailed))
                }
            }
        }
        group.notify(queue: .main) {
            completion(.success(()))
            self.updater?()
        }
    }
    
}
