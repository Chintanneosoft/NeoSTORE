import GoogleMaps
import GooglePlaces
import UIKit
import CoreLocation

//MARK: - StoreLocatorViewController
class StoreLocatorViewController: UIViewController, GMSMapViewDelegate {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var storeLocatorTableView: UITableView!
    
    //Properties
    let locationManager = CLLocationManager()
    let apiKey = "AIzaSyDu8Jcaz3rWu-e9I8xP2y2hSWnXYnW6IfY" // Replace with your actual API key
    var storeData:[String] = []
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        checkLocationAuthorization()
        setMapViewDelegates()
        setTableViewDelegates()
        setupMapView(with: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return StoreLocatorViewController(nibName: "StoreLocatorViewController", bundle: nil)
    }
    
    private func setUpUI(){
        setUpNavbar()
    }
    
    private func setUpNavbar(){
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        title = "Store Locator"
    }
    
    private func setMapViewDelegates(){
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        // Request location authorization and start updating location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    private func setTableViewDelegates(){
        storeLocatorTableView.delegate = self
        storeLocatorTableView.dataSource = self
        
        storeLocatorTableView.register(UINib(nibName: "StoreLocatorCell", bundle: nil), forCellReuseIdentifier: "StoreLocatorCell")
    }
    
    private func checkLocationAuthorization() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location access denied")
        default:
            break
        }
    }
    
    private func setupMapView(with initialCoordinate: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withTarget: initialCoordinate, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
    }

    func captureMapSnapshot() {
        UIGraphicsBeginImageContextWithOptions(mapView.bounds.size, mapView.isOpaque, 0.0)
        
        if let context = UIGraphicsGetCurrentContext() {
            mapView.layer.render(in: context)
            
            // Get the snapshot as an image
            let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    func findNearbyNatureLocations(userLocation: CLLocation) {
        let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        let locationString = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        let radius = "1000"  // 1 km
        let type = "restaurant"  // You can adjust this to your specific needs
        
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
                    DispatchQueue.main.async {
                        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
                        self.mapView.animate(to: camera)
                        
                        if let results = jsonObject["results"] as? [[String: Any]] {
                            for result in results {
                                if let name = result["name"] as? String,
                                   let geometry = result["geometry"] as? [String: Any],
                                   let location = geometry["location"] as? [String: Any],
                                   let lat = location["lat"] as? Double,
                                   let lng = location["lng"] as? Double,
                                   let types = result["types"] as? [String] {
                                    if types.contains("restaurant") {
                                        let marker = GMSMarker()
                                        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                        marker.title = name
                                        marker.icon = UIImage(named: "red_pin")
                                        marker.map = self.mapView
                                        self.storeData.append(name)
                                    } else {
                                        let marker = GMSMarker()
                                        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                        marker.title = name
                                        marker.map = self.mapView
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

extension StoreLocatorViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
            mapView.animate(to: camera)
            
            // Stop updating location to conserve battery
            manager.stopUpdatingLocation()
            findNearbyNatureLocations(userLocation: location)
            // Capture a snapshot of the mapView
            captureMapSnapshot()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
        // Handle the error as needed (e.g., show an alert to the user)
    }
}

extension StoreLocatorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeLocatorTableView.dequeueReusableCell(withIdentifier: "StoreLocatorCell", for: indexPath) as! StoreLocatorCell
        cell.lblLocatorName.text = storeData[indexPath.row]
        return cell
    }
}

