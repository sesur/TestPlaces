import UIKit
import MapKit
import Libraries
import PlacesAPI

/// A view that displays a list of places with search functionality.
public class TSPlacesView: LBView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: - Private. Data
    
    public var _places: [TSPlaceViewModel]!
    private var _filteredPlaces = [TSPlaceViewModel]()
    private let _tableView = UITableView(frame: .zero, style: .plain)
    private var _isSearching = false
    private let _searchBar = UISearchBar()
    private var _rectKeyboard: CGRect? = nil
    
    private struct Constants {
        static let title = "Places"
        static let placeholder = "Search"
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = TSUICommon.backgroundColor
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewController?.title = Constants.title
        setupSearchButton()
        updateTable()
    }
    
    // MARK: - Private Methods
    
    private func configureSubviews() {
        setupTableView()
        setupSearchBar()
        setupKeyboardNotifications()
    }
    
    private func setupTableView() {
        _tableView.rowHeight = UITableView.automaticDimension
        _tableView.estimatedRowHeight = TSUICommon.estimatedRowHeight
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.clipsToBounds = false
        _tableView.register(TSPlacesView.PlaceCell.self, forCellReuseIdentifier: TSPlacesView.PlaceCell.cellReuseId)
        self.addSubview(_tableView)
    }
    
    private func setupSearchBar() {
        _searchBar.delegate = self
        _searchBar.showsCancelButton = true
        _searchBar.isHidden = !_isSearching
        _searchBar.placeholder = Constants.placeholder
        self.addSubview(_searchBar)
    }
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self,
                                           action: #selector(toggleSearchBar(_:)))
        
        viewController?.navigationItem.rightBarButtonItem = searchButton
    }
    
    /// Updates the table with the list of places.
    private func updateTable() {
        _filteredPlaces = _places
        _tableView.reloadData()
    }
    
    /// Animates the table view reload.
    private func animateTableView() {
        UIView.transition(with: _tableView,
                          duration: TSUICommon.animationDuration,
                          options: .curveEaseInOut,
                          animations: {
            self._tableView.reloadSections([0], with: .fade)
        })
    }
    
    private func setupKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(onKeyboardEvent(obj:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(onKeyboardEvent(obj:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(onKeyboardEvent(obj:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(onKeyboardEvent(obj:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(onKeyboardEvent(obj:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(onKeyboardEvent(obj:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let rcBnds = self.bounds
        let rcContent = rcBnds.inset(by: self.safeAreaInsets)
        
        var rcSearchBar = rcBnds
        rcSearchBar.origin.y = rcContent.origin.y
        rcSearchBar.size.height = _searchBar.sizeThatFits(rcSearchBar.size).height
        
        var rcTable = rcContent
        if !_searchBar.isHidden, _searchBar.alpha > .zero {
            rcTable.origin.y = rcSearchBar.maxY
        }
        rcTable.size.height = rcContent.maxY - rcTable.origin.y
        
        var tableContentInset = UIEdgeInsets.zero
        if let rectKeyboard = _rectKeyboard {
            let rectKeyboard = self.convert(rectKeyboard, from: nil)
            let dy = rcTable.maxY - rectKeyboard.origin.y
            tableContentInset.bottom = max(dy, .zero)
        }
        
        _searchBar.frame = rcSearchBar
        _tableView.frame = rcTable
        _tableView.contentInset = tableContentInset
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _filteredPlaces.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TSPlacesView.PlaceCell.cellReuseId, for: indexPath) as? PlaceCell else {
            return UITableViewCell()
        }
        
        let placeInfo = _filteredPlaces[indexPath.row]
        cell.placeInfo = placeInfo
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToPlaceDetails(indexPath)
    }
    
    /// Navigates to the place details view for the selected row.
    private func navigateToPlaceDetails(_ indexPath: IndexPath) {
        let placeInfo = _filteredPlaces[indexPath.row]
        let placeView = TSPlaceView()
        let placeViewController = LBViewController(preloadedView: placeView)
        
        UIView.transition(with: _tableView,
                          duration: TSUICommon.animationDuration,
                          options: .curveEaseInOut,
                          animations: {
            placeView.placeInfo = placeInfo
            self.navigationController?.pushViewController(placeViewController, animated: true)
        }, completion: nil)
    }
    
    // MARK: - UISearchBarDelegate
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = searchBar.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: text)
        let trimmedText = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedText.isEmpty
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPlaces(with: searchText)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    private func filterPlaces(with searchText: String) {
        if searchText.isEmpty {
            _filteredPlaces = _places
        } else {
            _filteredPlaces = _places.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        animateTableView()
    }
    
    // MARK: - Events
    
    @objc
    private func toggleSearchBar(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: TSUICommon.animationDuration,
                       delay: 0,
                       usingSpringWithDamping: TSUICommon.dampingRatio,
                       initialSpringVelocity: TSUICommon.velocity,
                       options: [.curveEaseOut, .transitionCrossDissolve],
                       animations: {
            self._searchBar.isHidden = !self._searchBar.isHidden
            
            if !self._searchBar.isHidden {
                self._searchBar.becomeFirstResponder()
            } else {
                self._searchBar.text = ""
                self._searchBar.resignFirstResponder()
                self._filteredPlaces = self._places
                self.animateTableView()
            }
            
            self.layoutSubviews()
        })
    }
    
    @objc
    fileprivate func onKeyboardEvent(obj: AnyObject?) {
        var rectKeyboard: CGRect? = nil
        var animationDuration = TSUICommon.animationDuration
        if let notification = obj as? NSNotification, let userInfo = notification.userInfo {
            animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? animationDuration
            if let rect = ((userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) ?? (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue))?.cgRectValue {
                rectKeyboard = rect
            }
        }
        if _rectKeyboard != rectKeyboard {
            UIView.animate(withDuration: animationDuration, animations: {
                self._rectKeyboard = rectKeyboard
                self.layoutSubviews()
            })
        }
    }
}
