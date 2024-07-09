//
//  Array+Extensions+Tests.swift
//  TestPlacesUnitTests
//
//  Created by John Doe on 09.06.2024.
//

import XCTest
@testable import Libraries

final class ArrayExtensionsTests: XCTestCase {

	private let _testElement1 = "Test 1"
	private let _testElement2 = "Test 2"
	private let _testInt = 33
	private let _testColor: UIColor = .red

	private var _testArray: [Any]!
	private var _testColorArray: [UIColor]!

	override func setUp() {
		_testArray = [_testElement1, _testElement2, "Test 3", _testInt, _testColor]
		_testColorArray = [UIColor.blue, UIColor.blue, _testColor]
	}

	override func tearDown() {
		_testArray = nil
		_testColorArray = nil
	}

	// MARK: - Extension Array where Element: AnyObject

	func test_IsEqualByReferences() {
		let testArray2: [UIColor] = [UIColor.blue, UIColor.blue, UIColor.blue]

		let testArray3: [UIColor] = [UIColor.blue, UIColor.blue, _testColor]

		XCTAssertFalse(testArray2.isEqualByReferences(to: _testColorArray))
		XCTAssertTrue(_testColorArray.isEqualByReferences(to: testArray3))
	}

	func test_IndexOfReference() {
		XCTAssertEqual(_testColorArray.indexOfReference(to: _testColor), 2)
		XCTAssertNil(_testColorArray.indexOfReference(to: UIColor.green))
	}

	func test_ContainsReference() {
		XCTAssertTrue(_testColorArray.containsReference(to: _testColor))
		XCTAssertFalse(_testColorArray.containsReference(to: UIColor.green))
	}

}
