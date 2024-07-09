import UIKit
import Libraries
import PlacesAPI

/// Common interfaces for a type representing a place (TSPlaceInfo).
public protocol ITSPlaceContainer {
    
    /// Information about a place. required.
    var placeInfo: TSPlaceViewModel? { get set }
    
    /// Show a place. Optional.
    func show(placeInfo: TSPlaceViewModel, in navigationController: UINavigationController, completion: @escaping (() -> Void))
    
}

extension ITSPlaceContainer {
    
    public func show(placeInfo: TSPlaceViewModel, in navigationController: UINavigationController, completion: @escaping (() -> Void)) {
        NSLog("WARNING: %@", "show(placeInfo:, in navigationController:, completion:) has not been implemented")
        completion()
    }
    
}
