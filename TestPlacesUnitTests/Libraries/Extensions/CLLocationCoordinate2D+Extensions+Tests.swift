//
//  CLLocationCoordinate2D+Extensions+Tests.swift
//  TestPlacesUnitTests
//
//  Created by John Doe on 09.06.2024.
//

import XCTest
import CoreLocation
@testable import Libraries

final class CLLocationCoordinate2DExtensionsTests: XCTestCase {

	private let _testCoordinate = CLLocationCoordinate2D(latitude: 88.888, longitude: 55.555)

	func test_Equal() {
		XCTAssertTrue(_testCoordinate == CLLocationCoordinate2D(latitude: 88.888, longitude: 55.555))
	}

}
