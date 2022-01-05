//
//  RequestPapagoAPI.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/06.
//

import Foundation

struct RequestPapagoAPI: Codable {
    let source: String
    let target: String
    let text: String
}
