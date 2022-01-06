//
//  Language.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import Foundation

enum Language: String, Codable, CaseIterable {
    case ko
    case en
    case ja
    case ch = "zh-CN"
    
    var title: String {
        switch self {
        case .ko: return LocalizedString.korean
        case .en: return LocalizedString.english
        case .ja: return LocalizedString.japanese
        case .ch: return LocalizedString.chinese
        }
    }
    
    var translateCode: String {
        return rawValue
    }
}
