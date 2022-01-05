//
//  Bookmark.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}

