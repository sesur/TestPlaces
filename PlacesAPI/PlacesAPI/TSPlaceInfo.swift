import Foundation
import CoreLocation

/// Information about a place.
open class TSPlaceInfo: NSObject {

	// MARK: - Public

    open var name: String {
		return _name
	}

    open var coordinate: CLLocationCoordinate2D {
		return _coordinate
	}

	// MARK: - Public. Initialize

    public required init(name: String, coordinate: CLLocationCoordinate2D) {
		_name = name
		_coordinate = coordinate
	}

	// MARK: - Private. Data

	private let _name: String
	private let _coordinate: CLLocationCoordinate2D

	// MARK: -

}
