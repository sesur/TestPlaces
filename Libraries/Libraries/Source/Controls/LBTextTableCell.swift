import UIKit

/// Just shows a text.
open class LBTextTableCell: UITableViewCell {

	// MARK: - Public

	open var title: String? {
		get {
			return _labelTitle.text
		}
		set {
			if self.title != newValue {
				_labelTitle.text = newValue
			}
		}
	}

	// MARK: - Private. Data

	private let _labelTitle = UILabel()
	private var _constraints = [NSLayoutConstraint]()

	// MARK: - Private. Initialize

	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.separatorInset = .zero
		self.layoutMargins = .zero
		self.preservesSuperviewLayoutMargins = false

		_labelTitle.baselineAdjustment = .alignCenters
		_labelTitle.numberOfLines = 0
		_labelTitle.font = LBUICommon.labelTextFont
		_labelTitle.textColor = LBUICommon.labelTextColor
		_labelTitle.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(_labelTitle)

		self.setNeedsUpdateConstraints()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Layout

	open override func updateConstraints() {
		let insets = UIEdgeInsets(top: 12.0, left: 24.0, bottom: 12.0, right: 24.0)
		NSLayoutConstraint.deactivate(_constraints)
		_constraints = [
			_labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets.top),
			_labelTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0.0),
			_labelTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -insets.right),
			_labelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -insets.bottom),
		]
		NSLayoutConstraint.activate(_constraints)

		super.updateConstraints()
	}

	// MARK: -

}
