import UIKit

public extension UIView {

	/**
	 Get UIViewController this view belongs to
	 */
	var viewController: UIViewController? {
		if let nextResponder = self.next {
			if let viewController = nextResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}

	/**
	 Get UINavigationController this view belongs to
	 */
	var navigationController: UINavigationController? {
		if let viewControllervc = self.viewController {
			if let nvc = viewControllervc as? UINavigationController {
				return nvc
			} else if let nvc = viewControllervc.navigationController {
				return nvc
			}
		}
		return nil
	}

}
