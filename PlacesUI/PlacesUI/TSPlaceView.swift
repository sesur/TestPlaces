import UIKit
import MapKit
import Libraries
import PlacesAPI

/// A view that displays place details including a table view and a map view.
public class TSPlaceView: LBView, ITSPlaceContainer {
    
    /// The items to be displayed in the table view.
    private var items: [String] = []
    private let _tableView = UITableView(frame: .zero, style: .plain)
    private let _mapView = TSMapView()
    
    /// The view model containing place information.
    public var placeInfo: TSPlaceViewModel? {
        didSet {
            guard let placeInfo = placeInfo else { return }
            let name = placeInfo.name
            let latitudeAndLongitude = "\(placeInfo.coordinate.latitude), \(placeInfo.coordinate.longitude)"
            items = [name, latitudeAndLongitude]
            _mapView.placeInfo = placeInfo // Update map view with the view model
        }
    }
    
    // MARK: - Initialize
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = TSUICommon.backgroundColor
        configureTableView()
        setupTableViewLayout()
        configureTableViewFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func configureTableView() {
        _tableView.rowHeight = UITableView.automaticDimension
        _tableView.estimatedRowHeight = TSUICommon.estimatedRowHeight
        _tableView.dataSource = self
        _tableView.clipsToBounds = false
        _tableView.isScrollEnabled = false
        _tableView.allowsSelection = false
        _tableView.register(TSPlacesView.PlaceCell.self, forCellReuseIdentifier: TSPlacesView.PlaceCell.cellReuseId)
    }
    
    private func setupTableViewLayout() {
        self.addSubview(_tableView)
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _tableView.topAnchor.constraint(equalTo: self.topAnchor),
            _tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            _tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    /// Configures the table view footer with a map view.
    private func configureTableViewFooter() {
        DispatchQueue.main.async {
            let contentHeight = self._tableView.contentSize.height
            let screenHeight = UIScreen.main.bounds.height
            let availableHeight = screenHeight - contentHeight - self.safeAreaInsets.top
            
            self._mapView.frame = CGRect(x: .zero,
                                         y: .zero,
                                         width: self._tableView.frame.width,
                                         height: max(availableHeight, TSUICommon.estimatedRowHeight))
            self._mapView.placeInfo = self.placeInfo // Ensure map view is updated with the view model
            self._tableView.tableFooterView = self._mapView
        }
    }
}

// MARK: - UITableViewDataSource

extension TSPlaceView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = _tableView.dequeueReusableCell(withIdentifier: TSPlacesView.PlaceCell.cellReuseId) as? TSPlacesView.PlaceCell else {
            return TSPlacesView.PlaceCell(style: .default, reuseIdentifier: TSPlacesView.PlaceCell.cellReuseId)
        }
        
        cell.placeInfo = placeInfo
        cell.configureCell(indexPath: indexPath)
        return cell
    }
}
