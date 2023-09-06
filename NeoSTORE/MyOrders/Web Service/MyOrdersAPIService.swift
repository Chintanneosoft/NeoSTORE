//
//  MyOrdersAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

import UIKit

class MyOrdersAPIService: NSObject {
    func getOrderList(completion: @escaping(Result<MyOrderList,Error>) -> Void){
        APIManager.shared.callRequest(apiCallType: .getOrderList){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(MyOrderList.self, from: value)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
    }
}
