import XCTest
@testable import plutusApp

final class plutusAppTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(plutusApp().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
