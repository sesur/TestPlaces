import Foundation
import CoreLocation
import PlacesAPI
/*
 - Notes:
 
 Since this file is used in multiple locations, it makes sense to create a shared framework for it.
 
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