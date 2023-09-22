import UIKit

//MARK: - OrderDetailsAPIService
class OrderDetailsAPIService: NSObject {
    //API call
    func getOrderDetails(orderId: Int,completion: @escaping(Result<OrderDetails,Error>) -> Void){
        let param = [APIServiceText.orderId.rawValue: orderId]
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
                completion(.failure(error))
            }
        }
    }
}
