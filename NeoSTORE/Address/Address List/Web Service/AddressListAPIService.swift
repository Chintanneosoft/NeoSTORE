import UIKit
//MARK: - AddressListAPIService
class AddressListAPIService: NSObject {
    
    //MARK: - API Functions
    func placeOrder(addess: String,completion: @escaping(Result<OrderList,Error>) -> Void){
        let param = [APIServiceText.address.rawValue:addess]
        APIManager.shared.callRequest(apiCallType: .placeOrder(param: param)){ (response) in
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
