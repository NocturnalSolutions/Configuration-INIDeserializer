import Foundation
import Configuration
import INIParser

public class INIDeserializer: Deserializer {
    public let name = "ini"
    public func deserialize(data: Data) throws -> Any {
        guard let parser = try? INIParser(data: data) else {
            throw INIParser.Exception.InvalidFile
        }
        var values: [String: Any] = parser.sections.mapValues { $0 as Any }
        // Merge in "top-level" values, which INIParser calls "Anonymous
        // Section values, to the root level
        values.merge(parser.anonymousSection.mapValues { $0 as Any}) { _, new in new }

        return values as Any
    }

    // Empty init method to ensure it is public
    public init() {}
}
