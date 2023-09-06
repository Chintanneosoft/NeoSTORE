//
//  OrderDetailsAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 06/09/23.
//

import UIKit

class OrderDetailsAPIService: NSObject {
    func getOrderDetails(orderId: Int,completion: @escaping(Result<OrderDetails,Error>) -> Void){
        let param = ["order_id": orderId]
        APIManager.shared.callRequest(apiCallType: .getOrderDetail(param: param)){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(OrderDetails.self, from: value)
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
