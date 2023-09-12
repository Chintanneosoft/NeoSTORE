//
//  CartAPIService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 01/09/23.
//

import UIKit
//MARK: - CartAPIService
class CartAPIService: NSObject {
    
    //MARK: - Api Functions
    func getCartDetails(completion: @escaping(Result<(Cart?,UserFailure?),Error>) -> Void){
        
        APIManager.shared.callRequest(apiCallType: .getCart){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(Cart.self, from: value)
                    completion(.success((responseData,nil)))
                } catch {
                    do{
                        let responseData = try JSONDecoder().decode(UserFailure.self, from: value)
                        completion(.success((nil,responseData)))
                    }
                    catch{
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
    
    func updateCart(productId: Int,quantity: Int,completion: @escaping(Result<CartUpdate,Error>)-> Void){
        let param = ["product_id":productId,"quantity":quantity]
        APIManager.shared.callRequest(apiCallType: .updateCart(param: param)){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(CartUpdate.self, from: value)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
    
    func deleteCart(productId: Int,completion: @escaping(Result<CartUpdate,Error>)-> Void){
        let param = ["product_id":productId]
        APIManager.shared.callRequest(apiCallType: .deleteCart(param: param)){ (response) in
            
            switch response {
                
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(CartUpdate.self, from: value)
                    completion(.success(responseData))
                } catch {
                        completion(.failure(error))
                }
                
            case .failure(let error):
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
}
