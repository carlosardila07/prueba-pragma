//
//  NetworkManager.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import Foundation

import Alamofire
import PromiseKit

struct NetworkManager {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    let baseURL = "https://api.thecatapi.com/v1/"
    
    let serverErrorMessage = "Error de servidor"
    let defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "x-api-key" : "live_AGNdJalc2sXWNuboiNot5UXnyBcRSv1FoJwQO1ZWpYavunQFtUFc5c3UvQbCu2K1"
    ]
    
    func arrayRequest<Result: Codable> (_ route: String, method: HTTPMethod = .get) -> Promise<[Result]> {
        let completeUrl = self.baseURL + route + "?api_key=live_AGNdJalc2sXWNuboiNot5UXnyBcRSv1FoJwQO1ZWpYavunQFtUFc5c3UvQbCu2K1"
        debugPrint(completeUrl)
        return Promise <[Result]> { seal in
            let request = AF.request(completeUrl, method: method, headers: defaultHeaders)
            request.responseDecodable(completionHandler: { (result: DataResponse<[Result], AFError>) -> Void in
                if let error = result.error {
                    debugPrint(error.localizedDescription)
                    let customError = CustomError(title: nil, description: error.errorDescription ?? self.serverErrorMessage, code: 500)
                    seal.reject(customError)
                } else {
                    seal.resolve(result.value, nil)
                }
            })
        }
    }
}
