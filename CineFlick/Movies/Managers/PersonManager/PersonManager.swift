//
//  PersonManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

class PersonManager {
    // References / Properties
    static let shared = PersonManager()
    private lazy var personClient = PersonClient()
    private let group = DispatchGroup()
    private var updater: (() -> ())? = nil
    // Public Variables
    public var personBirthdate: String = "" { didSet { updater?() } }
    public var personBirthPlace: String = "" { didSet { updater?() } }
    public var personProfession: String = "" { didSet { updater?() } }
    public var personBiography: String = "" { didSet { updater?() } }
    
    // MARK: Person Request
    public func personRequest(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        group.enter()
        personClient.getPersonInfo(with: id) { (result) in
            switch result {
            case .success(let personData):
                defer { self.group.leave(); self.updater?() }
                guard let person = personData else { completion(.failure(.invalidData)); return }
                guard let birthdate = person.birthday else { return }
                guard let placeOfBirth = person.place_of_birth else { return }
                self.personBirthdate = birthdate
                self.personBirthPlace = placeOfBirth
                self.personProfession = person.known_for_department
                self.personBiography = person.biography
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
    
}
