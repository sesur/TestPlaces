import XCTest
import CoreLocation
import PlacesAPI

@testable import TestPlaces

class TSPlaceInfoTests: XCTestCase {
    
    private let cityName1 = "New York"
    private let cityName2 = "Los Angeles"
    
    func test_InitializationWithNameAndCoordinate() {
        let placeInfo = makeSUT(name: cityName1, latitude: 40.7128, longitude: -74.0060)
        
        XCTAssertEqual(placeInfo.name, cityName1)
        XCTAssertEqual(placeInfo.coordinate.latitude, 40.7128, accuracy: 0.0001)
        XCTAssertEqual(placeInfo.coordinate.longitude, -74.0060, accuracy: 0.0001)
    }
    
    func test_InitializationWithEmptyName() {
        let placeInfo = makeSUT(name: "", latitude: 40.7128, longitude: -74.0060)
        
        XCTAssertEqual(placeInfo.name, "")
        XCTAssertEqual(placeInfo.coordinate.latitude, 40.7128, accuracy: 0.0001)
        XCTAssertEqual(placeInfo.coordinate.longitude, -74.0060, accuracy: 0.0001)
    }
    
    func test_InequalityDifferentName() {
        let placeInfo1 = makeSUT(name: cityName1, latitude: 40.7128, longitude: -74.0060)
        let placeInfo2 = makeSUT(name: cityName2, latitude: 34.0522, longitude: -118.2437)
        
        XCTAssertNotEqual(placeInfo1, placeInfo2)
    }
    
    func test_InequalityDifferentCoordinate() {
        let placeInfo1 = makeSUT(name: cityName1, latitude: 40.7128, longitude: -74.0060)
        let placeInfo2 = makeSUT(name: cityName1, latitude: 37.7749, longitude: -122.4194)
        
        XCTAssertNotEqual(placeInfo1, placeInfo2)
    }
    
    // MARK: - Helper Method
    
    private func makeSUT(name: String, latitude: Double, longitude: Double) -> TSPlaceInfo {
        TSPlaceInfo(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
}
