import UIKit
import GoogleMaps
import GooglePlaces

class StoreLocatorViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 15.0)
//        mapView.camera = camera
//
//        // Find nearby restaurants
//        let placesClient = GMSPlacesClient.shared()
//        let location = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
//
//        let radiusMeters: Double = 1000 // Adjust the radius as needed
//        let query = "restaurant"
//
//        let filter = GMSAutocompleteFilter()
//        filter.type = .establishment
//
//        let request = GMSPlacesRequest(query: query, filter: filter, location: location, radius: radiusMeters)
//        placesClient.findPlaces(with: request) { (response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            if let places = response?.results {
//                for place in places {
//                    let marker = GMSMarker(position: place.coordinate)
//                    marker.title = place.name
//                    marker.snippet = place.formattedAddress
//                    marker.map = self.mapView
//                }
//            }
//        }
    }
    
}
