import XCTest
import Configuration

@testable import Configuration_INIDeserializer

final class Configuration_INIDeserializerTests: XCTestCase {

    let data = """
foo = "bar baz"
[qux]
quux = quuux
いろ= はにほへと
[ちりぬ]
asdf  = jkl ; comment
""".data(using: .utf8)

    func testConfigurationINI() {
        let config = ConfigurationManager()
        config.use(INIDeserializer())
        config.load(data: data!)
        XCTAssertEqual(config["foo"] as? String, "\"bar baz\"")
        if let qux = config["qux"] as? [String: String] {
            XCTAssertEqual(qux["quux"], "quuux")
            XCTAssertEqual(qux["いろ"], "はにほへと")
        }
        else {
            XCTFail("Couldn't retrieve config[\"qux\"]")
        }
        if let chirinu = config["ちりぬ"] as? [String: String] {
            XCTAssertEqual(chirinu["asdf"], "jkl")
        }
        else {
            XCTFail("Couldn't retrieve config[\"ちりぬ\"]")
        }
    }


    static var allTests = [
        ("testConfigurationINI", testConfigurationINI),
    ]
}
