import Foundation
import CoreLocation

/// List of places.
open class TSPlacesList: NSObject {

	// MARK: - Public

    public static var shared: TSPlacesList = {
		let shared = TSPlacesList()
		return shared
	} ()

	/// Currently, this is just a fixed list of places.
    /// Convert the list of TSPlaceInfo to TSPlaceViewModel instances, and sort them by name
    open var places: [TSPlaceViewModel] {
        return _places
            .map { TSPlaceViewModel(placeInfo: $0) }
            .sorted(by: { $0.name < $1.name })
    }

	// MARK: - Private. Data

	private var _places = [TSPlaceInfo]()

	// MARK: - Private. Initialize

	private override init() {
		super.init()

		// Fixed test data:
		_places.append(TSPlaceInfo(name: "New York", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)))
		_places.append(TSPlaceInfo(name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.773972, longitude: -122.431297)))
		_places.append(TSPlaceInfo(name: "Los Angeles", coordinate: CLLocationCoordinate2D(latitude: 34.052235, longitude: -118.243683)))
		_places.append(TSPlaceInfo(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)))
		_places.append(TSPlaceInfo(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.864716, longitude: 2.349014)))
		_places.append(TSPlaceInfo(name: "Madrid", coordinate: CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790)))
		_places.append(TSPlaceInfo(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.902782, longitude: 12.496366)))
		_places.append(TSPlaceInfo(name: "Berlin", coordinate: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954)))
		_places.append(TSPlaceInfo(name: "Lisbon", coordinate: CLLocationCoordinate2D(latitude: 38.736946, longitude: -9.142685)))
		_places.append(TSPlaceInfo(name: "Montreal", coordinate: CLLocationCoordinate2D(latitude: 45.630001, longitude: -73.519997)))
		_places.append(TSPlaceInfo(name: "Sydney", coordinate: CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900)))
		_places.append(TSPlaceInfo(name: "Rio de Janeiro", coordinate: CLLocationCoordinate2D(latitude: -22.908333, longitude: -43.196388)))
		_places.append(TSPlaceInfo(name: "Kyiv", coordinate: CLLocationCoordinate2D(latitude: 50.450001, longitude: 30.523333)))
		_places.append(TSPlaceInfo(name: "Warsaw", coordinate: CLLocationCoordinate2D(latitude: 52.237049, longitude: 21.017532)))
		_places.append(TSPlaceInfo(name: "Taumata­whakatangihanga­koauau­o­tamatea­turi­pukaka­piki­maunga­horo­nuku­pokai­whenua­ki­tana­tahu", coordinate: CLLocationCoordinate2D(latitude: -40.346, longitude: 176.5402)))
		_places.append(TSPlaceInfo(name: "Canton de Val de Lorraine Sud, France", coordinate: CLLocationCoordinate2D(latitude: 48.702327, longitude: 6.135898)))
		_places.append(TSPlaceInfo(name: "3901-3999 Millersville Dr, Indianapolis, IN 46205, USA", coordinate: CLLocationCoordinate2D(latitude: 39.827411, longitude: -86.124695)))
        _places.append(TSPlaceInfo(name: "Amsterdam", coordinate: CLLocationCoordinate2D(latitude: 52.367573, longitude: 4.904139)))
        _places.append(TSPlaceInfo(name: "Vienna", coordinate: CLLocationCoordinate2D(latitude: 48.208176, longitude: 16.373819)))
        _places.append(TSPlaceInfo(name: "Brussels", coordinate: CLLocationCoordinate2D(latitude: 50.850346, longitude: 4.351721)))
        _places.append(TSPlaceInfo(name: "Copenhagen", coordinate: CLLocationCoordinate2D(latitude: 55.676098, longitude: 12.568337)))
        _places.append(TSPlaceInfo(name: "Dublin", coordinate: CLLocationCoordinate2D(latitude: 53.349805, longitude: -6.26031)))
        _places.append(TSPlaceInfo(name: "Helsinki", coordinate: CLLocationCoordinate2D(latitude: 60.169856, longitude: 24.938379)))
        _places.append(TSPlaceInfo(name: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.913868, longitude: 10.752245)))
        _places.append(TSPlaceInfo(name: "Stockholm", coordinate: CLLocationCoordinate2D(latitude: 59.329323, longitude: 18.068581)))
        _places.append(TSPlaceInfo(name: "Zurich", coordinate: CLLocationCoordinate2D(latitude: 47.376887, longitude: 8.541694)))
        _places.append(TSPlaceInfo(name: "Prague", coordinate: CLLocationCoordinate2D(latitude: 50.075538, longitude: 14.4378)))
        _places.append(TSPlaceInfo(name: "Budapest", coordinate: CLLocationCoordinate2D(latitude: 47.497912, longitude: 19.040235)))
        _places.append(TSPlaceInfo(name: "Athens", coordinate: CLLocationCoordinate2D(latitude: 37.98381, longitude: 23.727539)))
        _places.append(TSPlaceInfo(name: "Bratislava", coordinate: CLLocationCoordinate2D(latitude: 48.148596, longitude: 17.107748)))
        _places.append(TSPlaceInfo(name: "Sofia", coordinate: CLLocationCoordinate2D(latitude: 42.697708, longitude: 23.321868)))
        _places.append(TSPlaceInfo(name: "Ljubljana", coordinate: CLLocationCoordinate2D(latitude: 46.056947, longitude: 14.505751)))
        _places.append(TSPlaceInfo(name: "Zagreb", coordinate: CLLocationCoordinate2D(latitude: 45.815011, longitude: 15.981919)))
        _places.append(TSPlaceInfo(name: "Belgrade", coordinate: CLLocationCoordinate2D(latitude: 44.786568, longitude: 20.448922)))
        _places.append(TSPlaceInfo(name: "Sarajevo", coordinate: CLLocationCoordinate2D(latitude: 43.856259, longitude: 18.413076)))
        _places.append(TSPlaceInfo(name: "Podgorica", coordinate: CLLocationCoordinate2D(latitude: 42.441233, longitude: 19.263611)))
        _places.append(TSPlaceInfo(name: "Tirana", coordinate: CLLocationCoordinate2D(latitude: 41.327546, longitude: 19.818698)))
        _places.append(TSPlaceInfo(name: "Chișinău", coordinate: CLLocationCoordinate2D(latitude: 47.010453, longitude: 28.863810)))

	}

	// MARK: -

}
