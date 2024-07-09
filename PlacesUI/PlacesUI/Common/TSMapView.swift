import MapKit
import Libraries
import PlacesAPI

/// Just a map.
open class TSMapView: LBMapView, ITSPlaceContainer {
    
    // MARK: - Public Properties
    
    public var placeInfo: TSPlaceViewModel? {
        get {
            return _placeInfo
        }
        set {
            if _placeInfo != newValue {
                _placeInfo = newValue
                
                if let annotation = _pinAnnotation {
                    self.removeAnnotation(annotation)
                    _pinAnnotation = nil
                }
                
                if let placeInfo = _placeInfo {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = placeInfo.coordinate
                    self.addAnnotation(annotation)
                    _pinAnnotation = annotation
                    
                    self.showCoordinate(placeInfo.coordinate, animated: false)
                }
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var _placeInfo: TSPlaceViewModel? = nil
    private var _pinAnnotation: MKPointAnnotation?
    
    // MARK: -
    
}
