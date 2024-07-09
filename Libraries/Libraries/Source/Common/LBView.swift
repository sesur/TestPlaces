import UIKit

/// Base class for a view in the project.
open class LBView: UIView {

	// MARK: - Overridable

	/// Called Only if this view is managed by LBViewController.
	open func viewDidLoad() {

	}

	/// Called when view is popped from navigation. Only if this view is managed by LBViewController in LBNavigationController.
	open func viewDidDismiss() {

	}

	// MARK: -

}
