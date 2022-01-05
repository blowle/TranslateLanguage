//
//  ResponsePapagoAPI.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/06.
//

import Foundation


struct ResponsePapagoAPI: Decodable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText }
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
}




