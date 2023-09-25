import UIKit
import CoreLocation
//MARK: - StoreLocatorViewModelDelegate
protocol StoreLocatorViewModelDelegate:AnyObject{
    func setLocationMarkers()
    func setLocationFail(msg: String)
}

//MARK: - StoreLocatorViewModel
class StoreLocatorViewModel: NSObject {
    weak var storeLocatorViewModelDelegate: StoreLocatorViewModelDelegate?
    let storeLocatorAPIService = StoreLocatorAPIService()
    
    var locationData : LocationData?
    var locationDataArray: [LocationData]?
    
    func findNearbyLocations(userLocation: CLLocation, type:String){
        storeLocatorAPIService.findNearbyNatureLocations(userLocation: userLocation, type: type) { response in
            switch response{
            case .success(let value):
                self.locationDataArray = []
                for result in value{
                    self.locationData = LocationData()
                    self.locationData?.name = result["name"] as? String
                    let geometry =  result["geometry"] as? [String: Any]
                    self.locationData?.geometry = geometry
                    let location = geometry?["location"] as? [String: Any]
                    self.locationData?.location = location
                    self.locationData?.lat = location?["lat"] as? Double
                    self.locationData?.lng = location?["lng"] as? Double
                    self.locationData?.types = result["types"] as? [String]
                    self.locationDataArray?.append(self.locationData!)
                    print(self.locationDataArray,"1", self.locationData,"2")
                }
                self.storeLocatorViewModelDelegate?.setLocationMarkers()
            case .failure(let error):
                self.storeLocatorViewModelDelegate?.setLocationFail(msg: error.localizedDescription)
            }
        }
    }
}
