//
//  PapagoAPI.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/06.
//

import Foundation

struct PapagoAPI {
    static let scheme = "https"
    static let host = "openapi.naver.com"
    static let path = "/v1/papago/n2mt"
    
    // source, target, text
    func getTranslatedText(by requestModel: RequestPapagoAPI) -> URLComponents {
        var components = URLComponents()
        
        components.scheme = PapagoAPI.scheme
        components.host = PapagoAPI.host
        components.path = PapagoAPI.path
        
//        components.queryItems = [
//            URLQueryItem(name: "source", value: requestModel.source),
//            URLQueryItem(name: "target", value: requestModel.target),
//            URLQueryItem(name: "text", value: requestModel.text)
//        ]
        
        return components
    }
}
