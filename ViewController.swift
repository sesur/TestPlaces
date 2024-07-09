import UIKit
import Libraries
import PlacesUI
import PlacesAPI

/// ViewController manages and displays a list of places using TSPlacesView.
public class ViewController: LBNavigationController {
    
    /// An array of TSPlaceViewModel instances representing the list of places to be displayed.
    public var placesList: [TSPlaceViewModel]!

    public override func viewDidLoad() {
        super.viewDidLoad()
    
        // Initialize TSPlacesView with the current view's bounds
        let placesView = TSPlacesView(frame: self.view.bounds)
        placesView._places = placesList
        
        let vc = LBViewController(preloadedView: placesView)
        self.pushViewController(vc, animated: false)
    }
}
