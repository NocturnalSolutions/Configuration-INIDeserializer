import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Configuration_INIDeserializerTests.allTests),
    ]
}
#endif