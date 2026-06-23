import Foundation

struct Category: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var colorHex: String?
}
