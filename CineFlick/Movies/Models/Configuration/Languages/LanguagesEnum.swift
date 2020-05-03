//
//  LanguagesEnum.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

enum LanguagesEnum: String, CaseIterable {
    case English = "en-US"
    case Italian = "it-IT"
    case Chinese = "zh-CN"
    case Hindi = "hi-IN"
    case Spanish = "es-ES"
    case French = "fr-FR"
    case Arabic = "ar-SA"
    case Bengali = "bn-BD"
    case Russian = "ru-RU"
    case Portuguese = "pt-PT"
    case Indonesian = "id-ID"
    
    init?(id: Int) {
        switch id {
        case 1: self = .English
        case 2: self = .Italian
        case 3: self = .Chinese
        case 4: self = .Hindi
        case 5: self = .Spanish
        case 6: self = .French
        case 7: self = .Arabic
        case 8: self = .Bengali
        case 9: self = .Russian
        case 10: self = .Portuguese
        case 11: self = .Indonesian
        default: return nil
        }
    }
}


enum RegionsEnum: String {
    case English = "US"
    case Italian = "IT"
    case Chinese = "CN"
    case Hindi = "IN"
    case Spanish = "ES"
    case French = "FR"
    case Arabic = "SA"
    case Bengali = "BD"
    case Russian = "RU"
    case Portuguese = "PT"
    case Indonesian = "ID"
}


enum LanguageNamesEnum: String, CaseIterable {
    case english = "English"
    case italian = "Italian"
    case chinese = "Chinese"
    case hindi = "Hindi"
    case spanish = "Spanish"
    case french = "French"
    case arabic = "Arabic"
    case bengali = "Bengali"
    case russian = "Russian"
    case portuguese = "Portuguese"
    case indonesian = "Indonesian"
}


enum NativeLanguagesEnum: String, CaseIterable {
    case english = "English"
    case italian = "Italiano"
    case chinese = "中文"
    case hindi = "हिन्दी"
    case spanish = "Español"
    case french = "Français"
    case arabic = "عربى"
    case bengali = "বাংলা"
    case russian = "Россия"
    case portuguese = "Português"
    case indonesian = "bahasa Indonesia"
}
