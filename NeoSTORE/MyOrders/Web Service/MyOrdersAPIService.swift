import UIKit

//MARK: - MyOrdersAPIService
class MyOrdersAPIService: NSObject {
    
    //API call
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
                completion(.failure(error))
            }
        }
    }
}
