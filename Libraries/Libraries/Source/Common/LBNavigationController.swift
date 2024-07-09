import UIKit

/// Base class for a navigation controller in the project.
open class LBNavigationController: UINavigationController {

	// MARK: - Private. Override

	@discardableResult
	open override func popViewController(animated: Bool) -> UIViewController? {
		let vc = self.viewControllers.last
		let lbvc = vc as? LBViewController
		let res = super.popViewController(animated: animated)
		if let lbvc {
			lbvc.viewDidDismiss()
		}
		return res
	}

	@discardableResult
	open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
		let vcs = self.viewControllers
		let count = vcs.count
		let index = vcs.indexOfReference(to: viewController)
		let result = super.popToViewController(viewController, animated: animated)
		if let index, index < count - 1 {
			for indexCur in (index + 1 ..< count).reversed() {
				let controller = vcs[indexCur]
				if let lbvc = controller as? LBViewController {
					lbvc.viewDidDismiss()
				}
			}
		}
		return result
	}

	@discardableResult
	open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		var vcs = self.viewControllers
		if vcs.count <= 1 {
			return super.popToRootViewController(animated: animated)
		}
		vcs.removeFirst()
		vcs.reverse()
		let res = super.popToRootViewController(animated: animated)
		for controller in vcs {
			if let lbvc = controller as? LBViewController {
				lbvc.viewDidDismiss()
			}
		}
		return res
	}

	open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
		if viewControllers.isEqualByReferences(to: self.viewControllers) {
			return
		}
		var viewControllersLast = self.viewControllers
		viewControllersLast.reverse()
		super.setViewControllers(viewControllers, animated: animated)
		for vcLast in viewControllersLast where !viewControllers.containsReference(to: vcLast) {
				let viewController = self.viewControllers.first
				if let lbvc = viewController as? LBViewController {
					lbvc.viewDidDismiss()
				}
		}
	}

	open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		let presentedVC = self.presentedViewController
		super.dismiss(animated: flag, completion: {
			if let presentedVC = presentedVC {

				if presentedVC.presentingViewController != nil {
					// Still presented. Started dismissing, but cancelled.
					completion?()
					return
				}

				var vcs = [UIViewController]()
				vcs.append(presentedVC)
				if let nvc = presentedVC as? UINavigationController {
					vcs.append(contentsOf: nvc.viewControllers)
				}
				for controller in vcs {
					if let lbvc = controller as? LBViewController {
						lbvc.viewDidDismiss()
					}
				}
			}
			completion?()
		})
	}

	// MARK: -

}
