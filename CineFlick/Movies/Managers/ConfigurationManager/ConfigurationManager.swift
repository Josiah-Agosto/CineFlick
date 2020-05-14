//
//  ConfigurationManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/28/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class ConfigurationManager {
    // References /  Properties
    static let shared = ConfigurationManager()
    private let group = DispatchGroup()
    private lazy var languageClient = LanguageClient()
    private lazy var countryClient = CountryClient()
    private lazy var imageClient = ImageClient()
    private let updater: (() -> ())? = nil
    // Image Properties
    public var secureBaseUrl: String = "" { didSet { updater?() } }
    public var imageSize: String = "" { didSet { updater?() } }
    public var backdropSize: String = "" { didSet { updater?() } }
    // Countries Properties
    public var countryNames: [String] = [] { didSet { updater?() } }
    public var countryAbbreviations: [String] = [] { didSet { updater?() } }
    // Language Properties
    public var englishLanguageNames: [String] = [] { didSet { updater?() } }
    public var englishLanguageAbbreviations: [String] = [] { didSet { updater?() } }
    public var nativeLanguageName: [String] = [] { didSet { updater?() } }
    // MARK: - Generate Image
    public func fetchImages() {
        group.enter()
        imageClient.createImage(from: .Images) { (result) in
            defer { self.group.leave() }
            switch result {
            case .success(let imageFeedResult):
                defer { self.updater?() }
                guard let imageCreation = imageFeedResult?.images else { return }
                guard let secure = imageCreation.secure_base_url else { return }
                guard let posterSize = imageCreation.poster_sizes?[4] else { return }
                guard let backdropSize = imageCreation.backdrop_sizes?[2] else { return }
                self.secureBaseUrl = secure
                self.imageSize = posterSize
                self.backdropSize = backdropSize
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Country
    public func fetchCountries() {
        group.enter()
        countryClient.countryClient(from: .Countries) { (result) in
            switch result {
            case .success(let countryData):
                defer { self.group.leave(); self.updater?() }
                guard let country = countryData else { return }
                for names in country {
                    self.countryNames.append(names.english_name)
                }
                for abbreviations in country {
                    self.countryAbbreviations.append(abbreviations.iso_3166_1)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Language
    public func fetchLanguages() {
        group.enter()
        languageClient.languageClient(from: .Languages) { (result) in
            switch result {
            case .success(let languageData):
                defer { self.group.leave(); self.updater?() }
                guard let languages = languageData else { return }
                for englishName in languages {
                    self.englishLanguageNames.append(englishName.english_name)
                }
                for abbreviation in languages {
                    self.englishLanguageAbbreviations.append(abbreviation.iso_639_1)
                }
                for nativeLanguage in languages {
                    self.nativeLanguageName.append(nativeLanguage.name)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    public func languageIsoEnumStrings() -> [String] {
        var arrayOfStrings: [String] = []
        for isoCode in LanguagesEnum.allCases {
            arrayOfStrings.append(isoCode.rawValue)
        }
        return arrayOfStrings
    }
    
    
    public func languageEnumNamesStrings() -> [String] {
        var arrayOfStrings: [String] = []
        for name in LanguageNamesEnum.allCases {
            arrayOfStrings.append(name.rawValue)
        }
        return arrayOfStrings
    }
    
    
    public func nativeLanguageNamesStrings() -> [String] {
        var arrayOfString: [String] = []
        for nativeName in NativeLanguagesEnum.allCases {
            arrayOfString.append(nativeName.rawValue)
        }
        return arrayOfString
    }
}
