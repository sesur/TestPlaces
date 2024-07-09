import UIKit
import Libraries
import PlacesAPI

extension TSPlacesView {
    
    public class PlaceCell: LBTextTableCell, ITSPlaceContainer {
        
        // MARK: - Public Properties
        
        static let cellReuseId = String(describing: PlaceCell.self)
        
        public var placeInfo: TSPlaceViewModel? {
            get {
                return _placeInfo
            }
            set {
                if _placeInfo != newValue {
                    _placeInfo = newValue
                    self.updateView()
                }
            }
        }
        
        // MARK: - Private Properties
        
        private var _placeInfo: TSPlaceViewModel? = nil
        
        // MARK: - Private Methods
        
        private func updateView() {
            self.title = _placeInfo?.name
        }
        
        // MARK: - ITSPlaceContainer Protocol
        
        /**
         Configures the cell based on the provided index path.
         
         - Parameter indexPath: The index path specifying the location of the cell in the table view.
         
         - Description
         
            The method sets the cell's title to the place's name if the row is 0.
            For other rows, it sets the title to the latitude and longitude of the place.
            If `_placeInfo` is `nil`, the method does nothing.
         */
        func configureCell(indexPath: IndexPath) {
            guard let placeInfo = _placeInfo else { return }
            
            if indexPath.row == 0 {
                self.title = placeInfo.name
            } else {
                let latitude = "Lat: " + placeInfo.coordinate.latitude.description
                let longitude = "Lng: " + placeInfo.coordinate.longitude.description
                self.title = latitude + ", " + longitude
            }
        }
    }
}
