import Foundation

struct SubwayStation: Identifiable, Codable {
    var id: String { "\(name)-\(line)" }
    let name: String
    let line: String
    let code: String
}
