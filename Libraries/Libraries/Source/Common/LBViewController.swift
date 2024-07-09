import UIKit

/// Base class for a controller in the project.
open class LBViewController: UIViewController {

	// MARK: - Initialize

	public convenience init(preloadedView: UIView) {
		self.init(nibName: nil, bundle: nil)
		_preloadedView = preloadedView
	}

	// MARK: - Private. Data

	private var _preloadedView: UIView?

	// MARK: - Override

	open override func loadView() {
		if _preloadedView != nil {
			self.view = _preloadedView
		} else {
			super.loadView()
		}
	}

	open override func viewDidLoad() {
		super.viewDidLoad()
		if self.isViewLoaded {
			if let view = self.view as? LBView {
				view.viewDidLoad()
			}
		}
	}

	/// Called when view is popped from navigation. Only if this view is managed by LBViewController in LBNavigationController.
	open func viewDidDismiss() {
		if self.isViewLoaded {
			if let lbv = self.view as? LBView {

				if let presentedVC = self.presentedViewController {
					if presentedVC.presentingViewController != nil {
						// Still presented. Started dismissing, but cancelled.
						return
					}
				}

				lbv.viewDidDismiss()
			}
		}
	}

	// MARK: -

}
