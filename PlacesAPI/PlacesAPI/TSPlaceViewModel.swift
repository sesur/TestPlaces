import Foundation
import CoreLocation

/*
 - Notes:
 
 Since this file is used in multiple locations, it makes sense to create a shared framework for it.
 I've now added it to PlacesAPI, so you should import only the API into the view controller (Main App)
 to be used in multiple locations.
 
 */

public struct TSPlaceViewModel {
    public let name: String
    public let coordinate: CLLocationCoordinate2D
    
    public init(placeInfo: TSPlaceInfo) {
        self.name = placeInfo.name
        self.coordinate = placeInfo.coordinate
    }
}

extension TSPlaceViewModel: Equatable {
    public static func ==(lhs: TSPlaceViewModel, rhs: TSPlaceViewModel) -> Bool {
        return lhs.name == rhs.name && lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}
