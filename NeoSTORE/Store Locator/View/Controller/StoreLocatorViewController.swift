import GoogleMaps
import GooglePlaces
import UIKit
import CoreLocation

//MARK: - StoreLocatorViewController
class StoreLocatorViewController: UIViewController, GMSMapViewDelegate {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var storeLocatorTableView: UITableView!
    @IBOutlet weak var btnShowList: UIButton!
    //Properties
    let locationManager = CLLocationManager()
    let storeLocatorViewModel = StoreLocatorViewModel()
    var storeData:[String] = []
    var mapView: GMSMapView!
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        checkLocationAuthorization()
        setTableViewDelegates()
        setupMapView(with: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
        setMapViewDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Functions
    static func loadFromNib() -> UIViewController {
        return StoreLocatorViewController(nibName: ViewControllerString.StoreLocator.rawValue, bundle: nil)
    }
    
    private func setUpUI(){
        btnShowList.layer.cornerRadius = 5
        btnShowList.titleLabel?.font = UIFont.customFont(Font.fontRegular, size: 15)
        setUpNavbar()
    }
    
    private func setUpNavbar(){
        setNavBarStyle(fontName: Font.fontBold.rawValue, fontSize: 26)
        navigationItem.title = ScreenText.Profile.navTitle.rawValue
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
        
        storeLocatorTableView.register(UINib(nibName: Cells.StoreLocatorCell.rawValue, bundle: nil), forCellReuseIdentifier: Cells.StoreLocatorCell.rawValue)
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
            print(AlertText.Message.locationPermissionDenied)
        default:
            break
        }
    }
    
    private func setupMapView(with initialCoordinate: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withTarget: initialCoordinate, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapViewContainer.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: mapViewContainer.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapViewContainer.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: mapViewContainer.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapViewContainer.bottomAnchor)
        ])
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
    
    func findNearbyLocations(userLocation: CLLocation) {
        showLoader()
        storeLocatorViewModel.storeLocatorViewModelDelegate = self
        storeLocatorViewModel.findNearbyLocations(userLocation: userLocation, type: ScreenText.StoreLocator.restaurant.rawValue)
    }
    
    //MARK: - IBActions
    @IBAction func btnShowListTapped(_ sender: UIButton) {
        storeLocatorTableView.isHidden = !storeLocatorTableView.isHidden
    }
}

//MARK: - CLLocationManagerDelegate
extension StoreLocatorViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
            mapView.animate(to: camera)
            
            // Stop updating location to conserve battery
            manager.stopUpdatingLocation()
            findNearbyLocations(userLocation: location)
            // Capture a snapshot of the mapView
            captureMapSnapshot()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - TableView
extension StoreLocatorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeLocatorTableView.dequeueReusableCell(withIdentifier: Cells.StoreLocatorCell.rawValue, for: indexPath) as! StoreLocatorCell
        cell.lblLocatorName.text = storeData[indexPath.row]
        return cell
    }
}

//MARK: - StoreLocatorViewModelDelegate
extension StoreLocatorViewController: StoreLocatorViewModelDelegate{
    func setLocationMarkers() {
        DispatchQueue.main.async {
            self.hideLoader()
            if let locationDatas = self.storeLocatorViewModel.locationDataArray{
                for result in locationDatas{
                    if ((result.types?.contains(ScreenText.StoreLocator.restaurant.rawValue)) != nil) {
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: result.lat ?? 0.0, longitude: result.lng ?? 0.0)
                        marker.title = result.name ?? ""
                        marker.map = self.mapView
                        self.storeData.append(result.name ?? "")
                        self.storeLocatorTableView.reloadData()
                    } else {
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: result.lat ?? 0.0, longitude: result.lng ?? 0.0)
                        marker.title = result.name
                        marker.map = self.mapView
                    }
                }
            } else {
                self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: AlertText.Message.locationNotFound.rawValue, okClosure: nil)
            }
        }
    }
    
    func setLocationFail(msg: String) {
        DispatchQueue.main.async {
            self.showSingleButtonAlert(title: AlertText.Title.error.rawValue, msg: msg, okClosure: nil)
        }
    }
}
