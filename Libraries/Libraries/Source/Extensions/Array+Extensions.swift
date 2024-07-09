import Foundation

public extension Array where Element: AnyObject {

	func isEqualByReferences<T: AnyObject>(to other: [T]) -> Bool {
		if self.count != other.count {
			return false
		}
		for index in 0 ..< self.count where self[index] !== other[index] {
			return false
		}
		return true
	}

	func indexOfReference(to object: AnyObject?) -> Int? {
		if let object = object {
			for (index, obj) in self.enumerated() where obj === object {
				return index
			}
		}
		return nil
	}

	func containsReference(to object: AnyObject?) -> Bool {
		if let object = object {
			for obj in self where obj === object {
				return true
			}
		}
		return false
	}

}
