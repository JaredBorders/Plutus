import XCTest

import plutusAppTests

var tests = [XCTestCaseEntry]()
tests += plutusAppTests.allTests()
XCTMain(tests)
