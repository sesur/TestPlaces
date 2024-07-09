import UIKit

/// Base class for a window in the project.
open class LBWindow: UIWindow {

	// MARK: - Private. Data

	private var _touchesShowingController: LBTouchesShowingController? = nil
	// Uncomment this to show touches:
	//private var _touchesShowingController: LBTouchesShowingController? = LBTouchesShowingController()

	// MARK: - Private. Override

	public override func sendEvent(_ event: UIEvent) {
		if let touchesShowingController = _touchesShowingController {
			if let touches = event.allTouches {
				for touch in touches {
					switch touch.phase {
						case .began:
							touchesShowingController.touchBegan(touch, view: self)
						case .moved:
							touchesShowingController.touchMoved(touch, view: self)
						case .ended, .cancelled:
							touchesShowingController.touchEnded(touch, view: self)
						default:
							break
					}
				}
			}
		}
		super.sendEvent(event)
	}

	// MARK: -

}

fileprivate class LBTouchesShowingController {

	// MARK: - Declarations

	private let _touchImageViewQueue = TouchImageViewQueue(touchesCount: 8)
	private var _touchImgViewsDict = [String: ImageView]()
	private var _touchesStartDateMapTable = [UITouch: Date]()

	// MARK: - Initialize

	public init() {

	}

	deinit {
		for view in _touchImgViewsDict.values {
			view.removeFromSuperview()
		}
		_touchImgViewsDict.removeAll()
	}

	// MARK: - Private Classes

	private struct Constants {
		static let imageSide: CGFloat = 48.0// 61.0
		static let ShortTapTresholdDuration = 0.11
		static let ShortTapInitialCircleRadius: CGFloat = 22.0
		static let ShortTapFinalCircleRadius: CGFloat = 57.0
	}

	private class ImageView: UIView {

		private let _circleView = UIView()

		override init(frame: CGRect) {
			super.init(frame: frame)
			self.backgroundColor = .clear
			_circleView.backgroundColor = UIColor(red: 0.0/255, green: 135.0/255, blue: 244.0/255, alpha: 0.8)
			_circleView.layer.shadowColor = _circleView.backgroundColor?.cgColor
			_circleView.layer.shadowOpacity = 1.0
			_circleView.layer.shadowOffset = .zero
			self.addSubview(_circleView)
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		override func layoutSubviews() {
			super.layoutSubviews()
			let rcBnds = self.bounds
			let minSide = min(rcBnds.size.width, rcBnds.size.height)
			var rcCtrls = rcBnds
			rcCtrls.size.width = minSide
			rcCtrls.size.height = rcCtrls.size.width
			rcCtrls.origin.x = rcBnds.midX - rcCtrls.size.width / 2.0
			rcCtrls.origin.y = rcBnds.midY - rcCtrls.size.height / 2.0
			self.layer.cornerRadius = rcCtrls.size.width / 2.0
			var rcCircle = rcCtrls
			rcCircle.size.width = rcCtrls.size.width * 0.8
			rcCircle.size.height = rcCircle.size.width
			rcCircle.origin.x = rcCtrls.midX - rcCircle.size.width / 2.0
			rcCircle.origin.y = rcCtrls.midY - rcCircle.size.height / 2.0
			_circleView.frame = rcCircle
			_circleView.layer.cornerRadius = rcCircle.size.width / 2.0
			_circleView.layer.shadowRadius = (rcCtrls.size.width - rcCircle.size.width) / 2.0
		}

		override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
			return nil
		}

	}

	private class TouchImageViewQueue {

		var backingArray = [ImageView]()

		convenience init(touchesCount: Int) {
			self.init()

			for _ in 0 ..< touchesCount {
				let imageView = ImageView(frame: CGRect(x: 0.0, y: 0.0, width: Constants.imageSide, height: Constants.imageSide))
				self.backingArray.append(imageView)
			}
		}

		func popTouchImageView() -> ImageView {
			return self.backingArray.removeFirst()
		}

		func push(_ touchImageView: ImageView) {
			self.backingArray.append(touchImageView)
		}
	}

	// MARK: - Private

	private func showExpandingCircle(at position: CGPoint, in view: UIView) {
		let circleLayer = CAShapeLayer()
		let initialRadius = Constants.ShortTapInitialCircleRadius
		let finalRadius = Constants.ShortTapFinalCircleRadius
		circleLayer.position = CGPoint(x: position.x - initialRadius, y: position.y - initialRadius)

		let startPathRect = CGRect(x: 0, y: 0, width: initialRadius * 2, height: initialRadius * 2)
		let startPath = UIBezierPath(roundedRect: startPathRect, cornerRadius: initialRadius)

		let endPathOrigin = initialRadius - finalRadius
		let endPathRect = CGRect(x: endPathOrigin, y: endPathOrigin, width: finalRadius * 2, height: finalRadius * 2)
		let endPath = UIBezierPath(roundedRect: endPathRect, cornerRadius: finalRadius)

		circleLayer.path = startPath.cgPath
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.strokeColor = UIColor(red: 0.0/255, green: 135.0/255, blue: 244.0/255, alpha: 0.8).cgColor
		circleLayer.lineWidth = 2.0
		view.layer.addSublayer(circleLayer)

		CATransaction.begin()
		CATransaction.setCompletionBlock {
			circleLayer.removeFromSuperlayer()
		}

		// Expanding animation
		let expandingAnimation = CABasicAnimation(keyPath: "path")
		expandingAnimation.fromValue = startPath.cgPath
		expandingAnimation.toValue = endPath.cgPath
		expandingAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		expandingAnimation.duration = 0.4
		expandingAnimation.repeatCount = 1.0
		circleLayer.add(expandingAnimation, forKey: "expandingAnimation")
		circleLayer.path = endPath.cgPath

		// Delayed fade out animation
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
			let fadingOutAnimation = CABasicAnimation(keyPath: "opacity")
			fadingOutAnimation.fromValue = 1.0
			fadingOutAnimation.toValue = 0.0
			fadingOutAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
			fadingOutAnimation.duration = 0.15
			circleLayer.add(fadingOutAnimation, forKey: "fadeOutAnimation")
			circleLayer.opacity = 0.0
		}

		CATransaction.commit()
	}

	private func touchImageView(for touch: UITouch) -> ImageView {
		return _touchImgViewsDict["\(touch.hash)"]!
	}

	private func setTouchImageView(_ touchImageView: ImageView, for touch: UITouch) {
		_touchImgViewsDict["\(touch.hash)"] = touchImageView
	}

	private func removeTouchImageView(for touch: UITouch) {
		_touchImgViewsDict.removeValue(forKey: "\(touch.hash)")
	}

	// MARK: - Public

	public func touchBegan(_ touch: UITouch, view: UIView) {
		let touchImgView = _touchImageViewQueue.popTouchImageView()
		touchImgView.center = touch.location(in: view)
		view.addSubview(touchImgView)

		touchImgView.alpha = 0.0
		touchImgView.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
		self.setTouchImageView(touchImgView, for: touch)

		UIView.animate(withDuration: 0.1) {
			touchImgView.alpha = 1.0
			touchImgView.transform = CGAffineTransform(scaleX: 1, y: 1)
		}

		_touchesStartDateMapTable[touch] = Date()
	}

	public func touchMoved(_ touch: UITouch, view: UIView) {
		self.touchImageView(for: touch).center = touch.location(in: view)
	}

	public func touchEnded(_ touch: UITouch, view: UIView) {
		var touchDuration: TimeInterval = 0.0
		if let touchStartDate = _touchesStartDateMapTable[touch] {
			touchDuration = Date().timeIntervalSince(touchStartDate)
		}
		_touchesStartDateMapTable[touch] = nil

		if touchDuration < Constants.ShortTapTresholdDuration {
			self.showExpandingCircle(at: touch.location(in: view), in: view)
		}

		let touchImgView = self.touchImageView(for: touch)
		UIView.animate(withDuration: 0.1, animations: {
			touchImgView.alpha = 0.0
			touchImgView.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
		}, completion: { (_) in
			touchImgView.removeFromSuperview()
			touchImgView.alpha = 1.0
			self._touchImageViewQueue.push(touchImgView)
			self.removeTouchImageView(for: touch)
		})
	}

	// MARK: -
}
