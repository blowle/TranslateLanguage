//
//  TranslatorManager.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/06.
//

import Foundation
import Alamofire

class TranslatorManager {
    
    static let shared: TranslatorManager = TranslatorManager()
    private init() { }
    
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(
        from text: String,
        completionHandler: @escaping (String) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        
        let requestModel = RequestPapagoAPI(
            source: sourceLanguage.rawValue,
            target: targetLanguage.translateCode,
            text: text)
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Constants.clientID,
            "X-Naver-Client-Secret": Constants.clientSecret,
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: requestModel,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponsePapagoAPI.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
