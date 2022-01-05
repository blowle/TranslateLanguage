//
//  PapagoNetwork.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/06.
//

import Foundation
import Alamofire
import SwiftUI

class PapagoNetwork {
    private let session: URLSession
    let api = PapagoAPI()

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func translate(
        source: String,
        target: String,
        text: String,
        completionHandler: @escaping (String) -> Void,
        ErrorHandler: @escaping (Error?) -> Void
    ) {
        
        guard let url = api.getTranslatedText(by: RequestPapagoAPI(source: source, target: target, text: text)).url
        else {
            return ErrorHandler(URLError(.badURL))
        }
        
        
        let json = [
            "source": source,
            "target": target,
            "text": text
        ]
        let data = try? JSONSerialization.data(withJSONObject: json, options: []) 
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Naver-Client-Id": Constants.clientID,
            "X-Naver-Client-Secret": Constants.clientSecret,
        ]
        
        request.headers = headers
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200..<300).contains(statusCode) else {
                ErrorHandler(error)
                return
            }

            do {
                let result = try JSONDecoder().decode(ResponsePapagoAPI.self, from: data!)
                completionHandler(result.translatedText)
            } catch let error {
                ErrorHandler(error)
            }
        }
        
        dataTask.resume()
    }
}
