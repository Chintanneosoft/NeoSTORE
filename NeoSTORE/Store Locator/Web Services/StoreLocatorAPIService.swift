import UIKit
import CoreLocation

//MARK: - StoreLocatorAPIService
class StoreLocatorAPIService: NSObject {
    
    let apiKey = "AIzaSyDu8Jcaz3rWu-e9I8xP2y2hSWnXYnW6IfY"
    let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    let radius = "1000"
    
    func findNearbyNatureLocations(userLocation: CLLocation,type: String,completion: @escaping(Result<([[String: Any]]),Error>)-> Void) {
        
        let locationString = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
//        let type = "restaurant"
        
        guard var components = URLComponents(string: baseUrl) else { return }
        components.queryItems = [
            URLQueryItem(name: "location", value: locationString),
            URLQueryItem(name: "radius", value: radius),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let finalUrl = components.url else { return }
        
        let task = URLSession.shared.dataTask(with: finalUrl) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let results = jsonObject["results"] as? [[String: Any]] {
                            completion(.success(results))
                    }
                }
            } catch {
                completion(.failure(error))
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
