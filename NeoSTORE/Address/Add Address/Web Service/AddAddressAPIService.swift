import UIKit
 
//MARK: - AddAddressAPIService
class AddAddressAPIService: NSObject {
    
    //MARK: - API call
    func addAddress(addess: String,completion: @escaping(Result<OrderList,Error>) -> Void){
        let param = ["address":addess]
        APIManager.shared.callRequest(apiCallType:.placeOrder(param: param)){ (response) in
            switch response {
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(OrderList.self, from: value)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
