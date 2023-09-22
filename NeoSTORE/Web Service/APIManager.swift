//
//  APIManager.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 23/08/23.
//

import Foundation

//MARK: - APIManager
class APIManager {
    // Shared Instance
    static let shared = APIManager()
    private init(){}
    
    // Common Request Function
    func callRequest(apiCallType: APIServices, completion: @escaping(Result<Data,Error>)->Void){
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: apiCallType.path)!)
        
        request.httpMethod = apiCallType.httpMethod
        
        if let parameter = apiCallType.param{
            
            if apiCallType.httpMethod == "POST" {
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = parameter.map{
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                request.httpBody = requestBodyComponents.query?.data(using: .utf8)
            }
            else{
                var urlComponents = URLComponents(string: apiCallType.path)
                urlComponents?.queryItems = parameter.map{
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                request.url = urlComponents?.url
            }
        }
        
        request.allHTTPHeaderFields = apiCallType.header
        
        let task = session.dataTask(with: request){ data, response, error in
            
            guard error == nil else{
                completion(.failure(error!))
                return
            }
            guard let content = data else {
                completion(.failure(error!))
                return
            }

            guard (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String:Any] != nil else {
                print("Not containing JSON")
                print("Response Content: \(String(data: content, encoding: .utf8) ?? "N/A")")
                return
            }
            completion(.success(content))
        }
        task.resume()
    }
}
