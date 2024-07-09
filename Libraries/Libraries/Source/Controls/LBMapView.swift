import MapKit

open class LBMapView: MKMapView {

	// MARK: - Public

    open func showCoordinate(_ coordinate: CLLocationCoordinate2D, animated: Bool) {
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
        self.setRegion(region, animated: true)
    }

	// MARK: - Private. Data

	// MARK: -

}
